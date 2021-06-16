from flask import  request, Blueprint, jsonify, make_response
from my_app import db
from my_app.models import Pessoas
from flask import Blueprint



createpessoa = Blueprint("createpessoa", __name__)


#VERIFICAÇÃO
#Realizar verificação se o seq já existe, caso sim, não deverá ser adiconado novamente


@createpessoa.route('/createpessoa', methods=['POST','OPTIONS'])
def CreatePessoa():
    try:
        if request.method == "OPTIONS":  # CORS preflight
            return _build_cors_prelight_response()
        elif request.method == "POST":
            content = request.json
            nomePessoaForm = content["nome"]
            sobrenomeForm = content["sobrenome"]
            cpfForm = content["cpf"]
            emailForm = content["email"]


            pessoa = Pessoas(nomePessoaForm, sobrenomeForm, cpfForm, emailForm)
            db.session.add(pessoa)
            db.session.commit()

    except Exception:
        
        return _corsify_actual_response(jsonify({'message': False})), 400
    return _corsify_actual_response(jsonify({'message': True})), 201

###
listpessoa = Blueprint("listpessoa", __name__)
@listpessoa.route('/listpessoa', methods=['GET', 'OPTIONS'])
def ListPessoa():
    try:
        if request.method == "OPTIONS":  # CORS preflight
            return _build_cors_prelight_response()
        elif request.method == "GET":
            pessoas = Pessoas.query.paginate(1, 10).items

            list = []
            for pessoa in pessoas:
                list.append({
                    'seqpessoa': pessoa.seqpessoa,
                    'nome': pessoa.nome,
                    'sobrenome': pessoa.sobrenome,
                    'cpf': pessoa.cpf,
                    'email': pessoa.email
                })
            return _corsify_actual_response(jsonify(list)), 200,

    except Exception :

        return _corsify_actual_response(jsonify({"message": False})), 400,

deletepessoa = Blueprint("deletepessoa", __name__)
@deletepessoa.route('/deletepessoa/<int:id>', methods=['GET', 'OPTIONS'])
def deletePessoa(id):
    try:
        if request.method == "OPTIONS":  # CORS preflight
            return _build_cors_prelight_response()
        elif request.method == "GET":
            Pessoas.query.filter_by(seqpessoa=id).delete()
            db.session.commit()
            return _corsify_actual_response(jsonify({"message": True})), 200,
    except:
        return _corsify_actual_response(jsonify({"message": False})), 400,

def _build_cors_prelight_response():
    response = make_response()
    response.headers.add("Access-Control-Allow-Origin", "*")
    response.headers.add('Access-Control-Allow-Headers', "*")
    response.headers.add('Access-Control-Allow-Methods', "*")
    return response

def _corsify_actual_response(response):
    response.headers.add("Access-Control-Allow-Origin", "*")
    return response