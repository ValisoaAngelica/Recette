from flask import Blueprint, request, redirect, url_for, render_template, current_app, session
from werkzeug.utils import secure_filename
from .models import Recette, Categorie, User
from . import db
import os




home_bp = Blueprint('home', __name__)


@home_bp.route('/home')
def home():
    if 'user_id' not in session:
        return redirect(url_for('home.login'))
    user_id = session['user_id']
    user = User.query.filter_by(id_user=user_id).first()
    categorie_selectionnee = request.args.get('categorie')

    if user is None:
        return redirect(url_for('home.login'))

    if categorie_selectionnee:
        categorie_obj = Categorie.query.filter_by(NOM_CATEGORIE=categorie_selectionnee).first()
        if categorie_obj:
            recette = Recette.query.filter_by(ID_CATEGORIE=categorie_obj.ID_CATEGORIE).all()
        else:
            recette = []
    else:
        recette = Recette.query.all()
    categorie = Categorie.query.all()
    name = user.username
    message = "Page CookHelp"
    return render_template('home.html', message=message, user_name=name, recette=recette, categorie=categorie)


@home_bp.route('/inscription', methods=['GET','POST'])
def inscription():
    title = "INSCRIPTION"
    if request.method == 'POST':
        username = request.form['username']
        email = request.form['email']
        mdp = request.form['cmdp']
        new_user = User(username=username,email=email,mot_de_passe=mdp)
        db.session.add(new_user)
        db.session.commit()

        session['user_id'] = new_user.id_user
        return redirect(url_for('home.home'))
    return render_template('create.html',title=title)

@home_bp.route('/', methods=['GET','POST'])
def login():
    if request.method == 'POST':
        email=request.form['email']
        mdp = request.form['mdp']

        user = User.query.filter_by(email=email).first()
        if user and user.mot_de_passe == mdp :
            session['user_id'] = user.id_user
            return redirect(url_for('home.home'))
    return render_template('login.html')
@home_bp.route('/logout')
def logout():
    session.pop('user_id', None)
    return redirect(url_for('home.login'))

@home_bp.route('/add_recette',methods=['GET','POST'])
def add():
    if 'user_id' not in session:
        return redirect(url_for('home.home'))
    user_id = session['user_id']
    user = User.query.filter_by(id_user=user_id).first()
    if user is None:
        return redirect(url_for('home.login'))

    name = user.email
    categories=Categorie.query.all()
    if request.method == 'POST':
        titre=request.form['titre']
        description=request.form['description']
        ingredients=request.form['ingredients']
        instruction=request.form['instructions']
        id_categorie = request.form['categorie']
        image=request.files['image']

        if image and image.filename != '':
            filename = secure_filename(image.filename)
            file_path = os.path.join(current_app.config['UPLOAD_FOLDER'], filename)
            image.save(file_path)
        else:
            filename = None
        
        new_recette=Recette(ID_CATEGORIE=id_categorie,ID_USER=user_id,TITRE=titre,DESCRIPTION=description,INGREDIENTS=ingredients,INSTRUCTIONS=instruction,IMAGE=filename)
        db.session.add(new_recette)
        db.session.commit()
        return redirect(url_for('home.home'))
        


    return render_template('form.html',categories=categories,email=name)

@home_bp.route('/listes')
def liste():
    if 'user_id' not in session:
        return redirect(url_for('home.home'))
    user_id = session['user_id']
    user = User.query.filter_by(id_user=user_id).first()
    if user is None:
        return redirect(url_for('home.login'))
    name=user.username

    recettes = Recette.query.filter_by(ID_USER=user_id).all()
    recettes_categories = [
        {
            'recette': recette,
            'categorie': Categorie.query.filter_by(ID_CATEGORIE=recette.ID_CATEGORIE).first()
        } 
        for recette in recettes
    ]

    return render_template('liste.html', user_name=name, recettes_categories=recettes_categories)
# @home_bp.route('/deleteRecette/<int : id_recette>')
# def deleteRecette(id_recette):
#     recette = Recette.query.filter_by(id_recette = id_recette).first()
#     db.session.delete(recette)
#     db.session.commit()
#     return redirect('/')


# @home_bp.route('/updateRecette/<int : id_recette>', methods=["POST","GET"])
# def updateRecette(id_recette):
#     if 'user_id' not in session:
#         return redirect(url_for('home.home'))
#     user_id = session['user_id']
#     user = User.query.filter_by(id_user=user_id).first()
#     if user is None:
#         return redirect(url_for('home.login'))
#     if request.method == 'POST':
#         titre = request.form['titre']
#         description = request.form['description']
#         ingredients = request.form['ingredients']
#         instructions = request.form['instructions']
#         categorie = request.form['categorie']
#         image = request.form['image']
        
#         recette = Recette.query.filter_by(id_recette = id_recette).first()
#         recette.titre = titre
#         recette.description = description
#         recette.ingredients = ingredients
#         recette.instructions = instructions
#         recette.categorie = categorie
#         recette.image = image
#         recette.id_user = user_id

#         db.session.add(recette)
#         db.session.commit()
#         return redirect('/')
#     recette = Recette.query.filter_by(id_recette = id_recette).first()
#     return render_template('modifierRecette.html', recette = recette)
    

@home_bp.route('/recette/<int:id>')
def recette_detail(id):
    if 'user_id' not in session:
        return redirect(url_for('home.login'))
    user_id = session['user_id']
    user = User.query.filter_by(id_user=user_id).first()
    name = user.username
    
    recette = Recette.query.filter_by(ID_RECETTE=id).first_or_404()
    
    return render_template('recette_detail.html', recette=recette, user_name=name)

