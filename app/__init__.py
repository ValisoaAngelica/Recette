from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from flask_migrate import Migrate
import os


db = SQLAlchemy()
migrate = Migrate()

def create_app():
    app = Flask(__name__, static_folder='../static', template_folder='../templates')

    app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql+pymysql://root:@localhost/recette'
    app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
    app.secret_key="recette"

    db.init_app(app)
    migrate.init_app(app, db)

    from .route import home_bp
    app.register_blueprint(home_bp)

    return app
