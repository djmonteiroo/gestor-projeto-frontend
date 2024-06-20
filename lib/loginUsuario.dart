import 'package:dasboard_project/services/autenticacaoUsuario.dart';
import 'package:flutter/material.dart';

class LoginUsuario extends StatelessWidget {
  LoginUsuario({Key? key}) : super(key: key);

  final _usuarioController = TextEditingController();
  final _senhaController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: _usuarioController,
                    decoration: InputDecoration(
                      labelText: 'Usuario:',
                      hintText: 'email@email.com',
                    ),
                    validator: (usuario) {
                      if (usuario == null || usuario.isEmpty) {
                        return 'Digite seu usuário';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 12),
                  TextFormField(
                    controller: _senhaController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Senha:',
                      hintText: 'Digite sua senha',
                    ),
                    validator: (senha) {
                      if (senha == null || senha.isEmpty) {
                        return 'Digite sua senha';
                      } else if (senha.length < 6) {
                        return 'Senha Invalida';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        logarUsuario(_usuarioController, _senhaController);
                      }
                    },
                    child: Text('Entrar'),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
