class Common
  def self.make_japanese_time(time)
    time.to_s.slice(0,4)+'年'+time.to_s.slice(5,2)+'月'+time.to_s.slice(8,2)+'日'+time.to_s.slice(11,2)+'時'+time.to_s.slice(14,2)+'分'
  end

  def self.make_japanese_date(date)
    date.to_s.slice(0,4)+'年'+date.to_s.slice(5,2)+'月'+date.to_s.slice(8,2)+'日'
  end

  def self.encrypt(pass)
    return add(pass.reverse)#plain_text
  end

  def self.decrypt(pass)
    return sub(pass.reverse)#plain_text
  end

  def self.add(s)
    sb = ''
    s.unpack("C*").each do |c|
		    new_char = c.to_i + 1
		    sb = sb+new_char.chr
		end
		return sb
	end

  def self.sub(s)
    sb = ''
		s.unpack("C*").each do |c|
		    new_char = c.to_i - 1
		    sb = sb+new_char.chr
		end
		return sb
	end

  def valid_email(email)
    valic_email_regex = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
    email =~ valic_email_regex
  end

end
