# -*- encoding : utf-8 -*-
class String
  def absolute_path
    Pathname.new(__FILE__).expand_path.join(self).cleanpath.to_s
  end
end
