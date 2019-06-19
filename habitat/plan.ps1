$pkg_name="national-parks"
$pkg_description="A sample JavaEE Web app deployed in the Tomcat8 package"
$pkg_origin="winhab"
$pkg_version="0.1.0"
$pkg_maintainer="Jeff Brimager <jbrimager@chef.io>"
$pkg_license=@('Apache-2.0')
$pkg_deps=@("winhab/tomcat8", "core/corretto8", "winhab/mongodb")
$pkg_build_deps=@("core/corretto8", "winhab/maven")
$pkg_svc_user="jbrim"
$pkg_binds=@{database="port"}
$pkg_exports=@{port="server.port"}
$pkg_exposes=@('port')

function Invoke-Prepare {
  $env:JAVA_HOME = "$(hab pkg path core/corretto8)"
  # $env:MAVEN_HOME = "$(hab pkg path winhab/maven)"
}
function Invoke-Build {
  Copy-Item "$PLAN_CONTEXT/../" "$HAB_CACHE_SRC_PATH/$pkg_dirname" -Recurse -Force -Verbose
  cd "$HAB_CACHE_SRC_PATH\${pkg_dirname}\$pkg_name"
  mvn package
}

function Invoke-Install{
  New-Item -ItemType Directory -Path "${pkg_prefix}/tc"
  Copy-Item "$HAB_CACHE_SRC_PATH\$pkg_dirname\$pkg_name\target\$pkg_name.war" "$pkg_prefix\tc" -verbose
  Copy-Item "$HAB_CACHE_SRC_PATH\$pkg_dirname\$pkg_name\data\national-parks.json" "$pkg_prefix\tc" -verbose
}
