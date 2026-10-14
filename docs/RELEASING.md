# Publicar uma release do KillNotify

O workflow `.github/workflows/release.yml` cria a GitHub Release automaticamente quando uma tag SemVer como `v1.0.1` é enviada. Antes de publicar, ele gera as localizações, verifica a formatação, executa `flutter analyze` e `flutter test`, valida a versão e compila um APK assinado. A release recebe o APK, o checksum SHA-256 e as notas da seção correspondente em `CHANGELOG.md`.

## Preparar assinatura

Use um keystore de release permanente e mantenha a mesma chave em todas as versões. Cadastre estes GitHub Actions secrets em **Settings > Secrets and variables > Actions**:

- `KILLNOTIFY_ANDROID_KEYSTORE_BASE64`: conteúdo Base64 do arquivo `.jks`;
- `KILLNOTIFY_ANDROID_KEYSTORE_PASSWORD`: senha do keystore;
- `KILLNOTIFY_ANDROID_KEY_ALIAS`: alias da chave;
- `KILLNOTIFY_ANDROID_KEY_PASSWORD`: senha da chave.

Os secrets ficam somente na configuração privada do repositório e nunca entram no Git. O workflow falha antes do build se algum deles estiver ausente ou inválido. O fallback para chave debug existe apenas em builds locais; o workflow não publica APKs assinados com a chave debug.

## Preparar uma versão

1. Atualize `version` em `pubspec.yaml` e `AppRelease.version` em `lib/core/version/app_release.dart` para a mesma versão SemVer, por exemplo `1.0.1`.
2. Adicione uma seção para essa versão no início de `CHANGELOG.md` e `CHANGELOG.pt-BR.md`, abaixo de **Unreleased/Em desenvolvimento**, no formato `## 1.0.1 - YYYY-MM-DD`. O workflow usa as notas em inglês de `CHANGELOG.md`.
3. Rode localmente `flutter gen-l10n`, `dart format lib test`, `flutter analyze`, `flutter test` e `flutter build apk --release`.
4. Faça commit das alterações e crie uma tag que corresponda exatamente à versão, por exemplo `v1.0.1`.
5. Envie o branch e a tag. O GitHub Actions executa as verificações, compila o APK assinado, calcula SHA-256 e cria a release com as notas do changelog.

Se a seção da versão não estiver no changelog, a release ainda recebe um título simples com o nome e a versão do app. Tags que não correspondam a `pubspec.yaml` ou `AppRelease.version` falham antes da publicação.

O projeto não publica na Google Play. O verificador no app consulta a release estável mais recente e abre o APK no navegador; o Android continua exigindo confirmação para instalar.

O Android está iniciando um processo de verificação de desenvolvedores: a primeira etapa regional de setembro de 2026 cobre lojas participantes, enquanto o sideload direto do GitHub não está nessa etapa inicial. O Google anunciou expansão global em 2027; acompanhe a [documentação Android de verificação de desenvolvedores](https://developer.android.com/developer-verification) e registre o pacote `com.killnotify.killnotify` na conta do proprietário antes que a distribuição direta seja afetada.
