gaussian_sources = [
  'main.vala',
  'application.vala',
  'enums.vala',
  'window.vala',
  'MathUtils.vala',

  'Widgets/DataList.vala',
  'Widgets/DistributionRow.vala',
  'Widgets/NavigationStack.vala',
  'Widgets/NavigationSwitcher.vala',
  'Widgets/ResultsList.vala',

  # Pages
  'Pages/BinomialPage.vala',
  'Pages/ChiSquaredPage.vala',
  'Pages/FDistributionPage.vala',
  'Pages/GeometricPage.vala',
  'Pages/HypergeometricPage.vala',
  'Pages/NormalPage.vala',
  'Pages/Page.vala',
  'Pages/PoissonPage.vala',
  'Pages/StudentPage.vala',

  'Models/Result.vala',
  'Models/DistributionTypes.vala',

  'Calculus/asa239.c',
  'Calculus/Calculus.vapi',

 'config.vapi',
]

conf = configuration_data()
conf.set_quoted('APP_ID', 'io.github.diegoivan.gaussian')
conf.set_quoted('G_LOG_DOMAIN', 'Gaussian')
conf.set_quoted('VERSION', meson.project_version())
conf.set_quoted('GETTEXT_PACKAGE', meson.project_name())
conf.set_quoted('DATADIR', join_paths(get_option('prefix'), get_option('datadir')))
conf.set_quoted('GNOMELOCALEDIR', join_paths(get_option('prefix'), get_option('localedir')))
configure_file(output: 'config.h', configuration: conf)

add_project_arguments(
    '-include', 'config.h',
    '-DGETTEXT_PACKAGE="@0@"'.format(meson.project_name()),
    language: 'c'
)

cc = meson.get_compiler('c')
math = cc.find_library('m', required: true)

gaussian_deps = [
  dependency('gtk4'),
  dependency('libadwaita-1', version: '>= 1.2'),
  dependency('gsl'),
  math,
]

gaussian_sources += gnome.compile_resources('gaussian-resources',
  'gaussian.gresource.xml',
  c_name: 'gaussian'
)

executable('gaussian', gaussian_sources,
  dependencies: gaussian_deps,
       install: true,
)
