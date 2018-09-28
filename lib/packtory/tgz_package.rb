require 'bundler'

module Packtory
  class TgzPackage
    INSTALL_PREFIX = '.'

    def self.build_package(opts = { })
      packager = Packer.new({ :binstub => { } }.merge(opts))
      fpm_exec = FpmExec.new(packager, INSTALL_PREFIX)

      sfiles_map = packager.prepare_files(INSTALL_PREFIX)
      package_filename = '%s-%s.tar.gz' % [ packager.package_name, packager.version ]
      pkg_file_path = fpm_exec.build(sfiles_map, package_filename, type: :tgz)

      Bundler.ui.info 'Created package: %s (%s bytes)' % [ pkg_file_path, File.size(pkg_file_path) ]

      [ packager, pkg_file_path ]
    end
  end
end