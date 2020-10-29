FROM werner01ai/g-py
RUN wget https://dist.nuget.org/win-x86-commandline/latest/nuget.exe && \
    dotnet new --install Boxed.Templates && \
    dotnet new nuget --name "N30"
WORKDIR "/N30/Source/N30"
RUN dotnet add package FSharp.Core && \
    dotnet add package Xamarin.Essentials && \
    dotnet add package Microsoft.ML && \
    dotnet add package Microsoft.ML.OnnxRuntime.Gpu && \
    dotnet add package Microsoft.ML.TensorFlow && \
    dotnet add package Google.Cloud.Firestore && \
    dotnet tool install -g --add-source "https://dotnet.myget.org/F/dotnet-try/api/v3/index.json" Microsoft.dotnet-interactive && \
    curl https://sh.rustup.rs -sSf | bash -s -- -y 
ENV PATH="$PATH:/root/.dotnet/tools:/root/.cargo/bin"
RUN dotnet interactive jupyter install && \
    dotnet nuget locals all -c &&  \
    cargo install sccache && \
    cargo install evcxr_jupyter && \
    cargo install cargo-script && \
    pip install rust-magic && \
    evcxr_jupyter --install
