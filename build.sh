PROJECT="$(echo "$1" | rev | cut -d/ -f1 | rev)"

cd contrib-api-doc

cp -r build.ci/* .

version="$(mvn -q -N org.codehaus.mojo:exec-maven-plugin:1.3.1:exec -Dexec.executable='echo' -Dexec.args='${project.version}' | tail -1)"
echo "version=$version"

# Copy stable site files
echo "Copying static site files"
cp -R site/* repo-docs

echo "Where are we and what is here?"
pwd
echo "===="
ls

# Run autodoc-collect
echo "Analyzing $PROJECT"
rm -f analysis.edn
echo "(def PROJECT \"$PROJECT\") (def VERSION \"$version\")" > proj.clj
cat proj.clj collect.clj | clojure -Sforce -J-Dclojure.spec.skip-macros=true -Sdeps "{:deps {org.clojure/${PROJECT} {:mvn/version \"RELEASE\"}}}" -M:collect -

# Run autodoc
echo "Building $PROJECT"
cat proj.clj build.clj | clojure -M:build -
