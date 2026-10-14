# Publicar uma release do KillNotify

O workflow `.github/workflows/release.yml` publica uma release quando uma tag `vMAJOR.MINOR.PATCH` é enviada. A tag deve corresponder ao campo `version` em `pubspec.yaml` (sem o número de build após `+`). O APK recebe o checksum SHA-256 como asset adicional.

## Preparar assinatura

Crie ou use um keystore de release permanente fora do repositório. Todas as versões precisam manter a mesma chave para que o Android aceite a atualização por cima da instalação existente.

Cadastre estes GitHub Actions secrets em **Settings > Secrets and variables > Actions**:

- `KILLNOTIFY_ANDROID_KEYSTORE_BASE64`: conteúdo Base64 do arquivo `.jks`;
- `KILLNOTIFY_ANDROID_KEYSTORE_PASSWORD`: senha do keystore;
- `KILLNOTIFY_ANDROID_KEY_ALIAS`: alias da chave;
- `KILLNOTIFY_ANDROID_KEY_PASSWORD`: senha da chave.

Os secrets nunca entram no Git. O workflow falha antes do build se algum estiver ausente.

## Publicar

1. Atualize `version` em `pubspec.yaml` e `AppRelease.version` em `lib/core/version/app_release.dart` para a mesma versão SemVer.
2. Atualize as notas de versão no `README.md` ou nas notas que serão anexadas ao tag.
3. Execute `flutter analyze` e compile localmente a variante release.
4. Faça commit das alterações e crie uma tag correspondente, por exemplo `v1.0.1`.
5. Envie o commit e a tag aprovada. O workflow valida a versão, compila APK assinado, calcula SHA-256 e cria a GitHub Release.

Este projeto não publica no Google Play. A busca no app consulta a última release estável e abre o asset APK no navegador. O Android ainda pede confirmação da instalação.

O Android está iniciando um processo de verificação de desenvolvedores: a primeira etapa regional de setembro de 2026 cobre lojas participantes, enquanto o sideload direto do GitHub não está nessa etapa inicial. O Google anunciou expansão global em 2027; acompanhe a [documentação Android de verificação de desenvolvedores](https://developer.android.com/developer-verification) e registre o pacote `com.killnotify.killnotify` na conta do proprietário antes que a distribuição direta seja afetada.
