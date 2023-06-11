gaussian_sources = [
  'main.vala',
  'application.vala',
  'window.vala',
]

gaussian_deps = [
  dependency('gtk4'),
  dependency('libadwaita-1', version: '>= 1.2'),
]

gaussian_sources += gnome.compile_resources('gaussian-resources',
  'gaussian.gresource.xml',
  c_name: 'gaussian'
)

executable('gaussian', gaussian_sources,
  dependencies: gaussian_deps,
       install: true,
)
