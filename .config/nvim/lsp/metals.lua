  if false then
    if shared.is_darwin() then
      return {
        cmd_end = {
          JAVA_HOME = '/Library/Java/JavaVirtualMachines/zulu-24.jdk/Contents/Home/',
        },
        settings = {
          metals = {
            javaHome = '/Library/Java/JavaVirtualMachines/zulu-11.jdk/Contents/Home/',
          },
        },
      }
  else
      return {}
    end
  end
