Pod::Spec.new do |spec|
  spec.name         = 'CommerciumX'
  spec.version      = '{{.Version}}'
  spec.license      = { :type => 'GNU Lesser General Public License, Version 3.0' }
  spec.homepage     = 'https://github.com/CommerciumBlockchain/go-CommerciumX'
  spec.authors      = { {{range .Contributors}}
		'{{.Name}}' => '{{.Email}}',{{end}}
	}
  spec.summary      = 'iOS CommerciumX Client'
  spec.source       = { :git => 'https://github.com/CommerciumBlockchain/go-CommerciumX.git', :commit => '{{.Commit}}' }

	spec.platform = :ios
  spec.ios.deployment_target  = '9.0'
	spec.ios.vendored_frameworks = 'Frameworks/CommerciumX.framework'

	spec.prepare_command = <<-CMD
    curl https://gethstore.blob.core.windows.net/builds/{{.Archive}}.tar.gz | tar -xvz
    mkdir Frameworks
    mv {{.Archive}}/CommerciumX.framework Frameworks
    rm -rf {{.Archive}}
  CMD
end
