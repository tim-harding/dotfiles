set -l jh /usr/libexec/java_home
if test -e $jh
    set -gx JAVA_HOME ($jh -v 24)
end
