gaussian_sources = [
  'main.vala',
  'application.vala',
  'enums.vala',
  'window.vala',
  'MathUtils.vala',

  'Widgets/BinomialPage.vala',
  'Widgets/Page.vala',
  'Widgets/PoissonPage.vala',
  'Widgets/ResultsList.vala',
  'Widgets/DataList.vala',

  'Models/Result.vala',
  'Models/DistributionTypes.vala',
]

cc = meson.get_compiler('c')
math = cc.find_library('m', required: true)

gaussian_deps = [
  dependency('gtk4'),
  dependency('libadwaita-1', version: '>= 1.2'),
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
