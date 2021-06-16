from flask import  request, Blueprint, jsonify, make_response
from my_app import db
from my_app.models import Users
from flask import Blueprint



login = Blueprint("login", __name__)


@login.route('/login',  methods=["POST", "OPTIONS"])
def Login():
    try:
        if request.method == "OPTIONS":  # CORS preflight
            return _build_cors_prelight_response()
        elif request.method == "POST":
            content = request.json
            usernameForm = content["email"]
            passwordForm = content["password"]
            user = Users.query.filter(
                Users.email == usernameForm, Users.password == passwordForm).first()
            if user:
                return _corsify_actual_response(jsonify({"message": True, "name": user.name,"lastname": user.lastname, "email": user.email})), 200,
            else:
                return _corsify_actual_response(jsonify({"message": False})), 401,
    except Exception:
        return _corsify_actual_response(jsonify({"message": False})), 400,


createuser = Blueprint("createuser", __name__)


@createuser.route('/createuser', methods=['POST', 'OPTIONS'])
def Createuser():
    try:
        if request.method == "OPTIONS":  # CORS preflight
            return _build_cors_prelight_response()
        elif request.method == "POST":
            content = request.json
            emailForm = content["email"]
            passwordForm = content["password"]
            nameForm = content["name"]
            lastnameForm = content["lastname"]

            user = Users(emailForm, passwordForm, nameForm, lastnameForm)
            db.session.add(user)
            db.session.commit()
    except Exception:

        return _corsify_actual_response(jsonify({'message': False})), 400
    return _corsify_actual_response(jsonify({'message': True})), 200


listuser = Blueprint("listuser", __name__)


@listuser.route('/listuser', methods=['GET', 'OPTIONS'])
def Listuser():
    try:
        if request.method == "OPTIONS":  # CORS preflight
            return _build_cors_prelight_response()
        elif request.method == "GET":
            users = Users.query.all()

            list = []
            for user in users:
                list.append({
                    'userid': user.id,
                    'name': user.name,
                    'lastname': user.lastname,
                    'email': user.email,

                })

            return _corsify_actual_response(jsonify(list)), 200,

    except Exception as e:
        erro = str(e)

        return _corsify_actual_response(jsonify({"message": erro})), 400,


deleteuser = Blueprint("deleteuser", __name__)


@deleteuser.route('/deleteuser/<int:id>', methods=['GET', 'OPTIONS'])
def deleteUser(id):
    try:
        if request.method == "OPTIONS":  # CORS preflight
            return _build_cors_prelight_response()
        elif request.method == "GET":
            Users.query.filter_by(id=id).delete()
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
