from flask import Flask
from flask_sqlalchemy import SQLAlchemy


app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:////temp/TesteFlutter.db'
db = SQLAlchemy(app)

from my_app.usuario import createuser,login,listuser, deleteuser
app.register_blueprint(createuser)
app.register_blueprint(login)
app.register_blueprint(listuser)
app.register_blueprint(deleteuser)

from my_app.quadras import createquadra,listquadra,deletequadra
app.register_blueprint(createquadra)
app.register_blueprint(listquadra)
app.register_blueprint(deletequadra)
from my_app.pessoas import createpessoa,listpessoa,deletepessoa
app.register_blueprint(createpessoa)
app.register_blueprint(listpessoa)
app.register_blueprint(deletepessoa)

from my_app.funcs import sendfile, importfile
app.register_blueprint(sendfile)
app.register_blueprint(importfile)

db.create_all()