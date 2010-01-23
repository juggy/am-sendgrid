require 'json'

class SmtpApiHeader

  def initialize()
    @data = {}
  end

  def addTo(to)
    if not @data['to']
      @data['to'] = []
    end
    if to.instance_of?(Array)
      @data['to'] = @data['to'] | to
    else
      @data['to'].push to
    end
  end

  def addSubVal(var, val)
    if not @data['sub']
      @data['sub'] = {}
    end
    if val.instance_of?(Array)
      @data['sub'][var] = val
    else
      @data['sub'][var] = [val]
    end
  end

  def setUniqueArgs(val)
    if val.instance_of?(Hash)
      @data['unique_args'] = val
    end
  end

  def setCategory(cat)

    @data['category'] = cat
  end

  def addFilterSetting(fltr, setting, val)
    if not @data['filters']
      @data['filters'] = {}
    end
    if not @data['filters'][fltr]
      @data['filters'][fltr] = {}
    end
    if not @data['filters'][fltr]['settings']
      @data['filters'][fltr]['settings'] = {}
    end
    @data['filters'][fltr]['settings'][setting] = val
  end

  def asJSON()
    json = @data.to_json
    return json.gsub(/(["\]}])([,:])(["\[{])/, '\\1\\2 \\3')
  end

  def as_string()
    json  = asJSON()
    str = 'X-SMTPAPI: %s' % json.gsub(/(.{1,72})( +|$\n?)|(.{1,72})/,"\\1\\3\n")
    return str
  end

end