from . import db
from datetime import datetime

class User(db.Model):
    __tablename__ = 'utilisateur'

    id_user = db.Column(db.Integer, primary_key=True, autoincrement=True)
    username = db.Column(db.String(255), nullable=False)
    email = db.Column(db.String(255), nullable=True)
    mot_de_passe = db.Column(db.String(255), nullable=False)

    def __repr__(self):
        return f'<User {self.username}>'


class Post(db.Model):
    __tablename__ = 'posts'
    id = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(255), nullable=False)
    content = db.Column(db.Text, nullable=False)

class Categorie(db.Model):
    __tablename__ = 'categorie'

    ID_CATEGORIE = db.Column(db.Integer, primary_key=True)
    NOM_CATEGORIE = db.Column(db.Text, nullable=False)

class Recette(db.Model):
    __tablename__ = 'recette'

    ID_RECETTE = db.Column(db.Integer, primary_key=True)
    ID_CATEGORIE = db.Column(db.Integer, nullable=False, index=True)
    ID_USER = db.Column(db.Integer, nullable=False, index=True)
    TITRE = db.Column(db.Text, nullable=False)
    DESCRIPTION = db.Column(db.Text)
    INGREDIENTS = db.Column(db.Text, nullable=False)
    INSTRUCTIONS = db.Column(db.Text, nullable=False)
    IMAGE = db.Column(db.Text)
    DATE_CREATION = db.Column(db.Date, default=datetime.utcnow)    
