# coding: utf-8
from sqlalchemy import Column, Date, Integer, String, Text
from sqlalchemy.ext.declarative import declarative_base

Base = declarative_base()
metadata = Base.metadata


class Categorie(Base):
    __tablename__ = 'categorie'

    ID_CATEGORIE = Column(Integer, primary_key=True)
    NOM_CATEGORIE = Column(Text, nullable=False)


class Post(Base):
    __tablename__ = 'posts'

    id = Column(Integer, primary_key=True)
    title = Column(String(255), nullable=False)
    content = Column(Text, nullable=False)


class Recette(Base):
    __tablename__ = 'recette'

    ID_RECETTE = Column(Integer, primary_key=True)
    ID_CATEGORIE = Column(Integer, nullable=False, index=True)
    ID_USER = Column(Integer, nullable=False, index=True)
    TITRE = Column(Text, nullable=False)
    DESCRIPTION = Column(Text)
    INGREDIENTS = Column(Text, nullable=False)
    INSTRUCTIONS = Column(Text, nullable=False)
    IMAGE = Column(Text)
    DATE_CREATION = Column(Date)


class Utilisateur(Base):
    __tablename__ = 'utilisateur'

    ID_USER = Column(Integer, primary_key=True)
    USERNAME = Column(Text, nullable=False)
    EMAIL = Column(Text)
    MOT_DE_PASSE = Column(Text, nullable=False)
