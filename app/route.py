from flask import Blueprint, request, redirect, url_for, render_template, current_app, session,flash
from werkzeug.utils import secure_filename
from .models import Recette, Categorie, User
from . import db
import os
from flask_login import login_required, current_user
from werkzeug.security import generate_password_hash, check_password_hash
from flask import jsonify, request, render_template, redirect, url_for, session
from sqlalchemy import or_


home_bp = Blueprint('home', __name__)


@home_bp.route('/profile', methods=['GET', 'POST'])
def profile():
    if 'user_id' not in session:
        return redirect(url_for('home.login'))
    user_id = session['user_id']
    user = User.query.filter_by(id_user=user_id).first()
    if request.method == 'POST':
        if 'update_info' in request.form:
            user.username = request.form['username']
            user.email = request.form['email']
            db.session.commit()
            flash('Profil mis à jour avec succès!', 'success')
        elif 'change_password' in request.form:
            if check_password_hash(user.mot_de_passe, request.form['current_password']):
                if request.form['new_password'] == request.form['confirm_password']:
                    user.mot_de_passe = generate_password_hash(request.form['new_password'], method='pbkdf2:sha256', salt_length=16)
                    db.session.commit()
                    flash('Mot de passe changé avec succès!', 'success')
                else:
                    flash('Les nouveaux mots de passe ne correspondent pas.', 'danger')
            else:
                flash('Mot de passe actuel incorrect.', 'danger')
        return redirect(url_for('home.profile'))
    return render_template('profile.html', user=user)

@home_bp.route('/home')
def home():
    if 'user_id' not in session:
        return redirect(url_for('home.login'))
    
    user_id = session['user_id']
    user = User.query.filter_by(id_user=user_id).first()
    
    if user is None:
        return redirect(url_for('home.login'))
    
    categorie_selectionnee = request.args.get('categorie')
    search_query = request.args.get('search', '')
    page = request.args.get('page', 1, type=int)
    per_page = 4  

    
    query = Recette.query

    
    if categorie_selectionnee:
        categorie_obj = Categorie.query.filter_by(NOM_CATEGORIE=categorie_selectionnee).first()
        if categorie_obj:
            query = query.filter_by(ID_CATEGORIE=categorie_obj.ID_CATEGORIE)

    
    if search_query:
        query = query.filter(or_(
            Recette.TITRE.ilike(f'%{search_query}%'),
            Recette.DESCRIPTION.ilike(f'%{search_query}%')
        ))

    
    recettes_paginated = query.paginate(page=page, per_page=per_page, error_out=False)
    recettes = recettes_paginated.items

    categories = Categorie.query.all()
    name = user.username
    message = "Page CookHelp"

    
    if request.headers.get('X-Requested-With') == 'XMLHttpRequest':
        return jsonify({
            'recettes': [{
                'ID_RECETTE': r.ID_RECETTE,
                'TITRE': r.TITRE,
                'DESCRIPTION': r.DESCRIPTION,
                'IMAGE': r.IMAGE
            } for r in recettes],
            'total_pages': recettes_paginated.pages,
            'current_page': page
        })

    return render_template('home.html', 
                           message=message, 
                           user_name=name, 
                           recette=recettes, 
                           categorie=categories,
                           pagination=recettes_paginated,
                           categorie_selectionnee=categorie_selectionnee)

@home_bp.route('/api/recipes')
def api_recipes():
    search = request.args.get('search', '')
    categorie_selectionnee = request.args.get('categorie', '')
    page = request.args.get('page', 1, type=int)
    per_page = 8

    query = Recette.query

    # Filtrer par catégorie
    if categorie_selectionnee:
        categorie_obj = Categorie.query.filter_by(NOM_CATEGORIE=categorie_selectionnee).first()
        if categorie_obj:
            query = query.filter_by(ID_CATEGORIE=categorie_obj.ID_CATEGORIE)

    # Filtrer par recherche
    if search:
        query = query.filter(or_(
            Recette.TITRE.ilike(f'%{search}%'),
            Recette.DESCRIPTION.ilike(f'%{search}%')
        ))

    recettes_paginated = query.paginate(page=page, per_page=per_page, error_out=False)
    recettes = recettes_paginated.items

    return jsonify({
        'recettes': [{
            'ID_RECETTE': r.ID_RECETTE,
            'TITRE': r.TITRE,
            'DESCRIPTION': r.DESCRIPTION,
            'IMAGE': r.IMAGE
        } for r in recettes],
        'total_pages': recettes_paginated.pages,
        'current_page': page
    })



@home_bp.route('/inscription', methods=['GET','POST'])
def inscription():
    title = "INSCRIPTION"
    if request.method == 'POST':
        username = request.form['username']
        email = request.form['email']
        mdp = request.form['cmdp']
        hashed_password = generate_password_hash(mdp, method='pbkdf2:sha256', salt_length=16)
        new_user = User(username=username,email=email,mot_de_passe=hashed_password)
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
        if user and check_password_hash(user.mot_de_passe, mdp):
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
@home_bp.route('/deleteRecette/<int:id_recette>', methods=['POST'])
def deleteRecette(id_recette):
    recette = Recette.query.filter_by(ID_RECETTE=id_recette).first()
    if recette:
        db.session.delete(recette)
        db.session.commit()
    else:
        flash("Recette non trouvée.", "danger")
    
    return redirect(url_for('home.home'))
@home_bp.route('/modifier_recette/<int:id_recette>', methods=['GET', 'POST'])
def modifier_recette(id_recette):
    if 'user_id' not in session:
        return redirect(url_for('home.home'))
    
    user_id = session['user_id']
    user = User.query.filter_by(id_user=user_id).first()
    if user is None:
        return redirect(url_for('home.login'))

    name = user.email
    categories = Categorie.query.all()
    recette = Recette.query.get_or_404(id_recette)

    if request.method == 'POST':
        recette.TITRE = request.form['titre']
        recette.DESCRIPTION = request.form['description']
        recette.INGREDIENTS = request.form['ingredients']
        recette.INSTRUCTIONS = request.form['instructions']
        recette.ID_CATEGORIE = request.form['categorie']
        
        image = request.files['image']
        if image and image.filename != '':
            filename = secure_filename(image.filename)
            file_path = os.path.join(current_app.config['UPLOAD_FOLDER'], filename)
            image.save(file_path)
            recette.IMAGE = filename  # Mettre à jour l'image si fournie

        db.session.commit()
        flash("Recette mise à jour avec succès.", "success")
        return redirect(url_for('home.home'))

    return render_template('modifier.html', categories=categories, email=name, recette=recette)
    

@home_bp.route('/recette/<int:id>')
def recette_detail(id):
    if 'user_id' not in session:
        return redirect(url_for('home.login'))
    user_id = session['user_id']
    user = User.query.filter_by(id_user=user_id).first()
    name = user.username
    
    recette = Recette.query.filter_by(ID_RECETTE=id).first_or_404()
    
    return render_template('recette_detail.html', recette=recette, user_name=name)

