OrdersController.class_eval do
  def rakennus
    load_order
    @invoice = true
    @template = "invoice"
  end
end
