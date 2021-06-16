from flask import  request, Blueprint, jsonify, make_response
from my_app import db
from my_app.models import Quadras
from flask import Blueprint


#Criação de quadra
createquadra = Blueprint("createquadra", __name__)





@createquadra.route('/createquadra', methods=['POST','OPTIONS'])
def Createquadra():

    #verificação try exception 
    try:
        if request.method == 'OPTIONS' :
            return _build_cors_prelight_response()
        
        elif request.method == 'POST':
            content = request.json
            descQuadraForm = content['descricao']
            tipoForm = content['tipo']
            comprimentoForm= float(content['comprimento'])
            larguraForm= float(content['largura'])

            #adiciona quadra
            quadra = Quadras(descQuadraForm, tipoForm, comprimentoForm, larguraForm)
            db.session.add(quadra)
            db.session.commit()
            return _corsify_actual_response(jsonify({'message': True})), 200
      
    #em caso de erro ao cadastrar quadra, retorna erro 400   
    except Exception:
        return _corsify_actual_response(jsonify({'message': False})), 400

   



listquadra = Blueprint("listquadra", __name__)

@listquadra.route('/listquadra', methods=['GET', 'OPTIONS'])
def ListQuadra():
    try:
        if request.method == "OPTIONS":  # CORS preflight
            return _build_cors_prelight_response()
        elif request.method == "GET":
            quadras = Quadras.query.paginate(1, 10).items
           
            list = []
            for quadra in quadras:
                list.append({
                    'seqquadra': quadra.seqquadra,
                    'descricao': quadra.descricao,
                    'tipo': quadra.tipo,
                    'comprimento': str(quadra.comprimento),
                    'largura': str(quadra.largura)
                })
               
            return _corsify_actual_response(jsonify(list)), 200,

    except Exception:
        
        return _corsify_actual_response(jsonify({"message": False})), 400,



deletequadra = Blueprint("deletequadra", __name__)


@deletequadra.route('/deletequadra/<int:id>', methods=['GET', 'OPTIONS'])
def deleteQuadra(id):
    try:
        if request.method == "OPTIONS":  # CORS preflight
            return _build_cors_prelight_response()
        elif request.method == "GET":
            Quadras.query.filter_by(seqquadra=id).delete()
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