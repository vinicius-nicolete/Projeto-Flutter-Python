from my_app import db


class Users(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    email = db.Column(db.String(100), nullable=False,  unique=True)
    password = db.Column(db.String(100), nullable=False)
    name = db.Column(db.String(100), nullable=False)
    lastname = db.Column(db.String(100), nullable=False)


    def __init__(self,email, password, name, lastname ):
        self.email = email
        self.password = password
        self.name = name
        self.lastname = lastname

    def __repr__(self):
        return '<Users %d>' % self.id

class Quadras(db.Model):
    seqquadra = db.Column(db.Integer, primary_key=True)
    descricao = db.Column(db.String(100), unique=True, nullable=False, )
    tipo = db.Column(db.String(100), nullable=False)
    comprimento = db.Column(db.Numeric(5,2), nullable=False )
    largura = db.Column(db.Numeric(5,2), nullable=False )

    def __init__(self, descricao, tipo, comprimento, largura):
       self.descricao = descricao
       self.tipo = tipo
       self.comprimento = comprimento
       self.largura = largura

    def __repr__(self):
        return '<Quadras %d>' % self.seqquadra


class Pessoas(db.Model):
    seqpessoa = db.Column(db.Integer, primary_key=True)
    nome = db.Column(db.String(100), nullable=False)
    sobrenome = db.Column(db.String(100), nullable=False)
    cpf = db.Column(db.String(14), nullable=False)
    email =db.Column(db.String(100), nullable=False)

    def __init__(self, nome, sobrenome, cpf, email):
       self.nome = nome
       self.sobrenome = sobrenome
       self.cpf = cpf
       self.email = email

    def __repr__(self):
        return '<Pessoas %d>' % self.seqpessoa
