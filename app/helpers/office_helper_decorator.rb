# encoding : utf-8
OfficeHelper.class_eval do
  def best_euros p
    euros(p).sub("€", "") + " / " + euros(p/1.24)
  end
end
