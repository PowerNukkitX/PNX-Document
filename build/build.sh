current_path=$(pwd)

if [[ $current_path =~ .*build$ ]]; then
    cd ..
fi

mkdir -p "target"
cd "target" || exit 1

# check whether FrostRender.jar exists
if [ ! -f "FrostRender.jar" ]; then
    echo "FrostRender.jar not found, downloading from GitHub..."

    download_url=$(curl -Ls "https://api.github.com/repos/PowerNukkitX/FrostDoc/releases/latest" \
      | grep -Eo '"browser_download_url": "https:.+?"' \
      | head -n 1 \
      | grep -Eo 'https:.+?\.jar')

    rm -f "FrostRender.jar"
    echo "Downloading FrostDoc from $download_url..."

    if [ -z "$HTTP_PROXY" ]; then
        echo "No proxy detected. You can set proxy via HTTP_PROXY environment variable."
        curl -Ls -o "FrostRender.jar" "$download_url"
    else
        echo "Using proxy $HTTP_PROXY"
        curl -Ls -x "$HTTP_PROXY" -o "FrostRender.jar" "$download_url"
    fi
fi

# check whether java17+ exists using which
if ! which java > /dev/null; then
    echo "Java 17+ is not installed, please install it and try again"
    exit 1
fi

# Render the docs
cd ..
java -Dfile.encoding=UTF-8 -jar "target/FrostRender.jar" -wd ./doc -od ./target/output