# Copyright 2009-2010 Open Information Security Foundation
# Copyright 2010-2011 Qualys, Inc.
#
# Licensed to You under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Author: Christopher Alfeld <calfeld@qualys.com>

module HTP
  # TODO: Lots to do.  Good inspect for all classes would be a good start.
  # As would an easier parsing interface that takes care of the return codes.
  
  class Header
    def invalid?
      flags & HTP_FIELD_INVALID != 0
    end
    
    def folded?
      flags & HTP_FIELD_FOLDED != 0
    end
    
    def repeated?
      flags & HTP_FIELD_REPEATED != 0
    end
    
    def to_s
      r = "#{name}: #{value}"
      r += " <INVALID>" if invalid?
      r += " <FOLDER>" if folded?
      r += " <REPEATED>" if repeated?
      r
    end
    
    alias :inspect :to_s
    alias :to_str :to_s
  end
  
  class HeaderLine
    def invalid?
      flags & HTP_FIELD_INVALID != 0
    end
    
    def long?
      flags & HTP_FIELD_LONG != 0
    end
    
    def nul_byte?
      flags & HTP_FIELD_NUL_BYTE != 0
    end
    
    def to_s
      line
    end
    
    alias :inspect :to_s
    alias :to_str :to_s
  end
  
  class URI
    def to_s
      if hostname
        "http://" +
        ( username ? username : '' ) +
        ( password ? ":#{password}" : '' ) +
        ( hostname ? "@#{hostname}:#{port}" : '' )
      else
        ''
      end + 
      ( path ? path : '' ) +
      ( query ? "?#{query}" : '' ) +
      ( fragment ? "##{fragment}" : '' )
    end
    
    alias :inspect :to_s
    alias :to_str :to_s
  end
  
  class Tx
    def invalid_chunking?
      flags & HTP_INVALID_CHUNKING != 0
    end
    
    def invalid_folding?
      flags & HTP_INVALID_FOLDING != 0
    end
    
    def request_smuggling?
      flags & HTP_REQUEST_SMUGGLING != 0
    end
    
    def multi_packet_header?
      flags & HTP_MULTI_PACKET_HEAD != 0
    end
    
    def field_unparseable?
      flags & HTP_FIELD_UNPARSABLE != 0
    end
  end
end