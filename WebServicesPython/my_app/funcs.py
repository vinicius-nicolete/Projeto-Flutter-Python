from flask import json, request, Blueprint, jsonify, make_response
from flask.helpers import send_from_directory
from werkzeug.utils import secure_filename
from my_app.models import Pessoas, Quadras, Users
from flask import Blueprint
from zipfile import ZipFile
from my_app import db


sendfile = Blueprint("sendfile", __name__)


@sendfile.route('/sendfile/<path:filename>', methods=['GET', 'OPTIONS'])
def sendFile(filename):
    try:
        if request.method == "OPTIONS":  # CORS preflight
            return _build_cors_prelight_response()
        elif request.method == "GET":
            users = Users.query.all()

            usuariosdict = {}
            for user in users:
                usuariosdict[user.id] = {
                    'name': user.name,
                    'lastname': user.lastname,
                    'email': user.email

                }

            f = open("usuarios.json", "w")
            json.dump(usuariosdict, f, sort_keys=True, indent=4)
            f.close()
            zipf = ZipFile("export.zip", "w",)
            zipf.write("usuarios.json")

            quadras = Quadras.query.all()
            quadrasdict = {}
            for quadra in quadras:
                quadrasdict[quadra.seqquadra] = {
                    'descricao': quadra.descricao,
                    'tipo': quadra.tipo,
                    'comprimento': str(quadra.comprimento),
                    'largura': str(quadra.largura)

                }

            f = open("quadras.json", "w")
            json.dump(quadrasdict, f, sort_keys=True, indent=4)
            f.close()
            zipf.write("quadras.json")
            pessoasdict = {}
            pessoas = Pessoas.query.all()
            for pessoa in pessoas:
                pessoasdict[pessoa.seqpessoa] = {
                    'nome': pessoa.nome,
                    'sobrenome': pessoa.sobrenome,
                    'cpf': pessoa.cpf,
                    'email': pessoa.email
                }

            f = open("pessoas.json", "w")
            json.dump(pessoasdict, f, sort_keys=True, indent=4)
            f.close()
            zipf.write("pessoas.json")
            zipf.close()

            return send_from_directory("C:\Projeto_AQD_final\WebServicesPython", filename, as_attachment=True)
            # return Response(data,
            #             mimetype="application/json",
            #             headers={"Content-Disposition":
            #                         "attachment;filename={}".format(filename)}),200

    except Exception as e:
        erro = str(e)
        return _corsify_actual_response(jsonify({"message": erro})), 400,


importfile = Blueprint("importfile", __name__)


@importfile.route('/importfile', methods=['POST', 'OPTIONS'])
def importFile():
    try:
        if request.method == "OPTIONS":  # CORS preflight
            return _build_cors_prelight_response()
        else:
            f = request.files['file']
            f.save(secure_filename(f.filename))
            tr = json.load(open('import.json'))

            i = 0
            for i in  range(len(tr)):
                nome = tr[i]['nome']
                sobrenome = tr[i]['sobrenome']
                cpf = tr[i]['cpf']
                email = tr[i]['email']
                i = i+1
                pessoas = Pessoas(nome,sobrenome,cpf,email)
                db.session.add(pessoas)
                db.session.commit()
            f.close()
            return _corsify_actual_response(jsonify({"message": True})), 200,
    except Exception as e:
        erro = str(e)
        return _corsify_actual_response(jsonify({"message": erro})), 400,


def _build_cors_prelight_response():
    response = make_response()
    response.headers.add("Access-Control-Allow-Origin", "*")
    response.headers.add('Access-Control-Allow-Headers', "*")
    response.headers.add('Access-Control-Allow-Methods', "*")
    return response


def _corsify_actual_response(response):
    response.headers.add("Access-Control-Allow-Origin", "*")
    return response
