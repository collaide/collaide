# -*- encoding : utf-8 -*-
#./run_guard.rb
exec 'rake db:test:prepare'
exec 'guard'
