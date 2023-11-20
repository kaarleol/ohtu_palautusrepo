from entities.user import User
import re


class UserInputError(Exception):
    pass


class AuthenticationError(Exception):
    pass


class UserService:
    def __init__(self, user_repository):
        self._user_repository = user_repository

    def check_credentials(self, username, password):
        if not username or not password:
            raise UserInputError("Username and password are required")

        user = self._user_repository.find_by_username(username)

        if not user or user.password != password:
            raise AuthenticationError("Invalid username or password")

        return user

    def create_user(self, username, password):
        self.validate(username, password)

        user = self._user_repository.create(
            User(username, password)
        )

        return user

    def validate(self, username, password):
        if not username or not password:
            raise UserInputError("Username and password are required")
        if not re.match("^[a-z]+$", username):
            raise UserInputError("Käyttäjätunnuksen tulee koostua merkeistä a-z")
        if not re.match("^(?=.*[^a-zA-Z]).+$", password):
            raise UserInputError("Salasana ei saa koostua pelkästään kirjaimista a-z")
        if not len(username) >= 3:
            raise UserInputError("Käyttäjätunnuksen pituuden tulee tulee olla ainakin 3 merkkiä")
        if not len(password) >= 8:
            raise UserInputError("Salasanan pituuden tulee tulee olla ainakin 8 merkkiä")

        
