class Validacoes {
  // Construtor privado: esta classe não deve ser instanciada.
  Validacoes._();

  // Valida campo obrigatório genérico.
  static String? obrigatorio(String? valor, {String campo = 'Este campo'}) {
    if (valor == null || valor.trim().isEmpty) {
      return '$campo é obrigatório';
    }
    return null;
  }

  // Valida nome completo: deve ter ao menos dois termos não vazios.
  static String? nomeCompleto(String? valor) {
    final obrigatorioErro = obrigatorio(valor, campo: 'O nome');
    if (obrigatorioErro != null) return obrigatorioErro;

    final partes = valor!.trim().split(' ').where((p) => p.isNotEmpty).toList();
    if (partes.length < 2) {
      return 'Informe nome e sobrenome';
    }
    return null;
  }

  // Valida formato de e-mail com expressão regular.
  static String? email(String? valor) {
    final obrigatorioErro = obrigatorio(valor, campo: 'O e-mail');
    if (obrigatorioErro != null) return obrigatorioErro;

    // Expressão regular para verificar o formato básico de e-mail.
    // Não garante que o domínio existe, apenas que o formato está correto.
    final regex = RegExp(r'^[a-zA-Z0-9._%+\-]+@[a-zA-Z0-9.\-]+\.[a-zA-Z]{2,}$');
    if (!regex.hasMatch(valor!.trim())) {
      return 'Informe um e-mail válido (ex: usuario@email.com)';
    }
    return null;
  }

  // Valida telefone brasileiro: aceita (11) 91234-5678 ou 11912345678.
  // Remove caracteres não numéricos antes de verificar o tamanho.
  static String? telefone(String? valor) {
    final obrigatorioErro = obrigatorio(valor, campo: 'O telefone');
    if (obrigatorioErro != null) return obrigatorioErro;

    final apenasDigitos = valor!.replaceAll(RegExp(r'\D'), '');
    if (apenasDigitos.length < 10 || apenasDigitos.length > 11) {
      return 'Informe um telefone válido com DDD';
    }
    return null;
  }

  // Valida senha: mínimo 8 caracteres, ao menos uma maiúscula e um número.
  static String? senha(String? valor) {
    final obrigatorioErro = obrigatorio(valor, campo: 'A senha');
    if (obrigatorioErro != null) return obrigatorioErro;

    if (valor!.length < 8) {
      return 'A senha deve ter no mínimo 8 caracteres';
    }
    if (!valor.contains(RegExp(r'[A-Z]'))) {
      return 'A senha deve conter ao menos uma letra maiúscula';
    }
    if (!valor.contains(RegExp(r'[0-9]'))) {
      return 'A senha deve conter ao menos um número';
    }
    return null;
  }

  // Valida confirmação de senha: deve ser igual ao valor fornecido.
  // Recebe a senha original como parâmetro — exemplo de validador com closure.
  static String? Function(String?) confirmarSenha(String senhaOriginal) {
    return (String? valor) {
      final obrigatorioErro = obrigatorio(
        valor,
        campo: 'A confirmação de senha',
      );
      if (obrigatorioErro != null) return obrigatorioErro;
      if (valor != senhaOriginal) {
        return 'As senhas não coincidem';
      }
      return null;
    };
  }
}
