# 📚 Potencialize — App de Cursos

Aplicativo mobile desenvolvido com **Flutter** e **Supabase**, focado em gerenciamento e acesso a cursos online.

---

## 🚀 Tecnologias

| Tecnologia | Descrição |
|---|---|
| [Flutter](https://flutter.dev) | Framework UI multiplataforma |
| [Dart](https://dart.dev) | Linguagem de programação |
| [Supabase](https://supabase.com) | Backend as a Service (Auth + Database) |
| [image_picker](https://pub.dev/packages/image_picker) | Seleção de imagens da galeria/câmera |
| [flutter_native_splash](https://pub.dev/packages/flutter_native_splash) | Tela de splash nativa |
| [flutter_launcher_icons](https://pub.dev/packages/flutter_launcher_icons) | Ícone do aplicativo |

---

## 📁 Estrutura do Projeto

```
lib/
├── core/
│   └── supabase_client.dart    # Configuração do cliente Supabase
├── pages/
│   ├── splash_page.dart        # Tela de splash / redirecionamento
│   ├── login_page.dart         # Tela de login
│   ├── register_page.dart      # Tela de cadastro
│   ├── home_page.dart          # Tela principal
│   └── my_courses.dart         # Meus cursos
├── services/
│   ├── auth_service.dart       # Serviço de autenticação
│   └── course_service.dart     # Serviço de cursos
└── main.dart                   # Entry point da aplicação
```

---

## ✨ Funcionalidades

- 🔐 **Autenticação** — Login e cadastro de usuários via Supabase Auth
- 🎓 **Listagem de Cursos** — Visualização de cursos disponíveis
- 📖 **Meus Cursos** — Cursos do usuário autenticado
- 🖼️ **Upload de Imagem** — Seleção de imagem de perfil com `image_picker`
- 🌟 **Splash Screen** — Tela de carregamento nativa

---

## ⚙️ Configuração e Instalação

### Pré-requisitos

- Flutter SDK `^3.11.0`
- Conta no [Supabase](https://supabase.com)

### Passos

1. **Clone o repositório:**
   ```bash
   git clone https://github.com/seu-usuario/potencialize_flutter.git
   cd app_cursos
   ```

2. **Instale as dependências:**
   ```bash
   flutter pub get
   ```

3. **Configure o Supabase** em `lib/main.dart`:
   ```dart
   await Supabase.initialize(
     url: 'SUA_SUPABASE_URL',
     anonKey: 'SUA_ANON_KEY',
   );
   ```

4. **Execute o app:**
   ```bash
   flutter run
   ```

---

## 🎨 Tema Visual

- **Cor primária:** `#7C3AED` (Roxo)
- **Cor secundária:** `#F59E0B` (Âmbar)
- **Background:** `#F3F4F6` (Cinza claro)

---

## 📄 Licença

Este projeto é de uso educacional.
