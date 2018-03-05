@echo off

if not exist %delphiooLib%\ooBatch\ (
  @echo "Clonning ooBatch..."
  git clone https://github.com/VencejoSoftware/ooBatch.git %delphiooLib%\ooBatch\
  call %delphiooLib%\ooBatch\code\get_dependencies.bat
)

if not exist %delphiooLib%\ooNet\ (
  @echo "Clonning ooNet..."
  git clone https://github.com/VencejoSoftware/ooNet.git %delphiooLib%\ooNet\
  call %delphiooLib%\ooNet\code\get_dependencies.bat
)

if not exist %delphi3rdParty%\synapse\ (
  @echo "Clonning synapse..."
  git clone https://github.com/VencejoSoftware/AraratSynapse.git %delphi3rdParty%\synapse\
)

if not exist %delphi3rdParty%\ujson\ (
  @echo "Clonning ujson..."
  git clone https://github.com/VencejoSoftware/uJSON.git %delphi3rdParty%\ujson\
)

if not exist %delphi3rdParty%\simplexml\ (
  @echo "Clonning simplexml..."
  git clone https://github.com/VencejoSoftware/simplexml.git %delphi3rdParty%\simplexml\
)