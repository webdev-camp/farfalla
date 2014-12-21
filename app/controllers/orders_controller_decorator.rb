OrdersController.class_eval do
  def rakennus
    load_order
    @invoice = true
    @template = "rakennus"
  end
end
