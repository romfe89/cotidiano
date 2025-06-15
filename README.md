# 📆 Cotidiano

Cotidiano é um aplicativo Flutter para Android que oferece uma lista de tarefas **diárias** com persistência local usando **SQLite**. Ideal para manter o foco em hábitos, rotinas e pequenos compromissos que se repetem todos os dias.

## ✨ Funcionalidades

- ✅ Lista de tarefas com marcação diária
- 🔄 Tarefas são resetadas automaticamente a cada novo dia
- 📝 Edição e exclusão de tarefas
- 📦 Armazenamento local via `sqflite`
- 🎨 Tema retrô com cores roxas e ícones personalizados

## 🚀 Instalação

1. Clone o repositório:

```bash
 git clone https://github.com/seu-usuario/cotidiano.git
 cd cotidiano
```

2. Instale as dependências:

```bash
flutter pub get
```

3. Rode o app em um dispositivo Android:

```bash
flutter run
```

## 🔐 Assinatura e build para produção

Certifique-se de configurar seu arquivo key.properties e .keystore para gerar builds de produção:

```bash
flutter build apk --release
```

A chave de assinatura não está incluída no repositório por motivos de segurança.

## 📂 Estrutura do projeto

lib/
├── main.dart  
├── models/  
│ └── task.dart  
├── db/  
│ └── task_database.dart  
├── screens/  
│ └── task_list_screen.dart  
└── widgets/  
└── task_form.dart

## 🛠️ Tecnologias

- Flutter

- Dart

- sqflite

- path_provider

## 👤 Autor

Desenvolvido por Rômulo Fernandes Evangelista
