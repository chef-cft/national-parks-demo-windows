$pkg_name="national-parks"
$pkg_description="A sample JavaEE Web app deployed in the Tomcat8 package"
$pkg_origin="winhab"
$pkg_version="1.1.0"
$pkg_maintainer="Jeff Brimager <jbrimager@chef.io>"
$pkg_license=@('Apache-2.0')
$pkg_deps=@("winhab/tomcat8", "core/corretto8", "winhab/mongodb")
$pkg_build_deps=@("core/corretto8", "core/maven")
$pkg_binds_optional=@{database="port"}
$pkg_exports=@{port="server.port"}
$pkg_exposes=@('port')

function Invoke-Build {
  Copy-Item "$PLAN_CONTEXT/../" "$HAB_CACHE_SRC_PATH/$pkg_dirname" -Recurse -Force
  cd "$HAB_CACHE_SRC_PATH\${pkg_dirname}\src"
  mvn package
}

function Invoke-Install{
  Copy-Item "$HAB_CACHE_SRC_PATH\$pkg_dirname\src\target\$pkg_name.war" "$pkg_prefix\"
  Copy-Item "$HAB_CACHE_SRC_PATH\$pkg_dirname\src\data\national-parks.json" "$pkg_prefix\"
}
