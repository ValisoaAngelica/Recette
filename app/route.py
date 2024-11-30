# app/route.py
from flask import Blueprint, render_template,request, jsonify,redirect,url_for,session
from .models import User,db


home_bp = Blueprint('home', __name__)


@home_bp.route('/home')
def home():
    if 'user_id' not in session:
        return redirect(url_for('home.login'))
    user_id = session['user_id']
    user = User.query.filter_by(id_user=user_id).first()

    if user is None:
        return redirect(url_for('home.login'))

    name = user.username
    message = "Page CookHelp"
    return render_template('home.html', message=message, user_name=name)


@home_bp.route('/', methods=['GET','POST'])
def login():
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

@home_bp.route('/login', methods=['GET','POST'])
def log():
    if request.method == 'POST':
        email=request.form['email']
        mdp = request.form['mdp']

        user = User.query.filter_by(email=email).first()
        if user and user.mot_de_passe == mdp :
            session['user_id'] = user.id_user
            return redirect(url_for('home.home'))
        else:
            print(erreur)
    return render_template('login.html')
@home_bp.route('/logout')
def logout():
    session.pop('user_id', None)
    return redirect(url_for('home.login'))
