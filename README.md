# KillNotify

KillNotify é um aplicativo Android local para controlar quando notificações de outros apps podem aparecer. A interface é Flutter; o listener e toda a decisão semanal rodam em Kotlin, sem depender de uma tela ou engine Dart em segundo plano.

O projeto não tem conta, backend, sincronização, telemetria ou publicidade. A única conexão de rede é a busca opcional de atualizações na API pública do GitHub; ela não transmite configurações, apps ou notificações. Os APKs são distribuídos manualmente pelo GitHub, fora da Play Store.

## Estado

O MVP implementa programação semanal por app, exceções, lista de apps, estado/permissões locais e backup JSON versionado. O protótipo `snoozeNotification` foi observado em um emulador Android API 36. Isso não garante o mesmo comportamento em outros aparelhos, perfis ou fabricantes.

Veja [requisitos](docs/requirements/REQUIREMENTS.md), [arquitetura](docs/architecture/ARCHITECTURE.md), [decisões](docs/decisions/DECISOES.md), [política de privacidade](docs/PRIVACIDADE.md), [processo de release](docs/RELEASING.md), [plano](docs/plans/2026-10-13-mvp/PLAN.md) e [resultados do protótipo](docs/prototype/ANDROID_API36_EMULATOR.md).

Veja também a [política de privacidade](docs/PRIVACIDADE.md) e o [processo de publicação de releases](docs/RELEASING.md).

## Compilar e verificar

Requisitos de desenvolvimento: Flutter 3.47+, Android SDK com API 36 e JDK 17. `minSdk` é API 26. No PowerShell, da raiz:

```powershell
flutter pub get
flutter analyze
flutter test
cd android
.\gradlew.bat --no-daemon :app:testDebugUnitTest
cd ..
flutter build apk --debug
flutter build apk --release
```

O APK debug fica em `build/app/outputs/flutter-apk/app-debug.apk`; o release fica ao lado. Sem propriedades de assinatura release, o APK release é assinado com a chave debug e serve somente para verificação local. Instale manualmente com:

```powershell
adb install -r build/app/outputs/flutter-apk/app-debug.apk
```

O protótipo usa um app produtor separado com notificações sintéticas, ações e agrupamento. Ele é ferramenta de desenvolvimento, não integra o APK KillNotify:

```powershell
cd android
.\gradlew.bat --no-daemon :notification-probe:assembleDebug
```

O produtor fica em `build/notification-probe/outputs/apk/debug/notification-probe-debug.apk`.

Nesta estação Windows, o JDK falhou ao criar o socket temporário NIO usado pelo Gradle sem um caminho Unix-domain curto. Se aparecer `Unable to establish loopback connection`, crie `C:\Temp` e rode os comandos Gradle nesta sessão do PowerShell após:

```powershell
$env:JAVA_TOOL_OPTIONS='-Djdk.net.unixdomain.tmpdir=C:/Temp'
```

## Uso e limitações

1. Conceda o acesso especial de notificações nas configurações Android.
2. Permita a atividade do KillNotify em segundo plano na confirmação de bateria do Android. Sem o acesso ao listener ou essa exceção, o filtro não pode ser ativado.
3. Se o aparelho tiver controles próprios para limitar apps em segundo plano, permita que o KillNotify continue ativo. Exemplos documentados: Samsung **Apps nunca suspensos**; Xiaomi **Inicialização automática em segundo plano** e, se disponível, **Sem restrições**; Huawei **Inicialização de apps** com inicialização automática/secundária e execução em segundo plano; realme **Gerenciamento de bateria dos apps** permitindo segundo plano e inicialização automática; OPPO/ColorOS e OnePlus **Gerenciamento de bateria dos apps**, sem restringir atividade em segundo plano; vivo **Acesso especial a apps > Inicialização automática**; Motorola **Gerenciar apps em segundo plano > Sempre permitir**, se disponível. Os nomes e opções variam por modelo e versão; o KillNotify não consegue verificar essas opções do fabricante.
4. Não é necessário manter a tela do KillNotify aberta. Evite usar **Forçar parada**, que impede o Android de entregar callbacks ao serviço até reconectá-lo.
5. Selecione apps, configure períodos por dia e ative o filtro. Um app sem regra configurada passa.
6. O Android entrega novamente a notificação original via snooze; o KillNotify reavalia a regra quando ela retorna. O tempo não é exato e pode variar por economia de bateria, fabricante ou mudanças no relógio.
7. Chamadas/alarmes só passam quando o app de origem fornece a categoria Android correspondente. OTP não é identificado pelo conteúdo.
8. Para permitir qualquer app instalado, o manifesto usa `QUERY_ALL_PACKAGES`; a lista é lida no aparelho e não é transmitida.
9. O backup SAF é JSON versionado e contém apenas configurações. Pacotes ausentes são preservados e avisados.
10. Em **Configurações > Aparência**, escolha entre seis cores de destaque ou personalize uma cor por HEX/RGB. A escolha fica no aparelho e também é incluída no backup.
11. Em **Configurações > Atualizações**, deixe a busca automática ligada para consultar as releases do GitHub no máximo uma vez por dia, ou faça uma busca manual. Ao encontrar uma versão nova, escolha baixar, lembrar amanhã ou desligar os avisos. O APK abre no navegador e o Android solicita confirmação para instalar.

“Individualmente, em um resumo” foi interpretado como reapresentar cada original individualmente e mostrar na tela a contagem liberada, sem criar uma segunda notificação sintética. A decisão está registrada em `docs/decisions/DECISOES.md` e pode ser revisada.

A API oficial limita notification listeners em aparelhos de pouca memória com Android Q ou anterior e em work profiles. A exceção de bateria pode ser revogada e não supera toda política de memória ou controles próprios do fabricante. A reentrega após mudança de fuso/relógio e a experiência de agrupamento exigem validação adicional em aparelhos reais; não há teste físico nesta entrega. O filtro fica inativo se qualquer pré-requisito detectável for revogado.

A busca de atualizações consulta apenas `https://api.github.com/repos/leonardobordin/KillNotify/releases/latest`; o GitHub recebe os metadados normais da conexão, incluindo endereço IP e User-Agent com a versão. Preferências e horários da busca ficam no aparelho e não entram no backup JSON.

Não publique uma release com a chave debug. Para uma APK distribuível, configure as propriedades Gradle `killnotifyReleaseKeystore`, `killnotifyReleaseStorePassword`, `killnotifyReleaseKeyAlias` e `killnotifyReleaseKeyPassword` fora do repositório (por exemplo, em `~/.gradle/gradle.properties`). Sem essas propriedades, a variante release usa a chave debug apenas para verificação local. O workflow de release por tag precisa dos secrets documentados em [docs/RELEASING.md](docs/RELEASING.md). Nenhuma release foi publicada.
