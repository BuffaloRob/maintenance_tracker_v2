module LogsHelper

  def formatted_date_performed(log)
    log.date_performed.strftime("%b %d, %Y")
  end

  def formatted_date_due(log)
    log.date_due.strftime("%b %d, %Y")
  end
end
