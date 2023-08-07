
version="$(cd repo && mvn -q -N org.codehaus.mojo:exec-maven-plugin:1.3.1:exec -Dexec.executable='echo' -Dexec.args='${project.version}' | tail -1)"
echo "version=$version"

echo "Where are we?"
ls

cd ..

echo "Where are we now"
ls

# Copy stable site files
echo "Copying static site files"
cp -R contrib/site/* repo-docs

echo "Status"
ls
