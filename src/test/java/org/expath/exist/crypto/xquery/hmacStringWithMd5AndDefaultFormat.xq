(:
 : eXist-db EXPath Cryptographic library
 : eXist-db wrapper for EXPath Cryptographic Java library
 : Copyright (C) 2016 Kuberam
 :
 : This library is free software; you can redistribute it and/or
 : modify it under the terms of the GNU Lesser General Public License
 : as published by the Free Software Foundation; either version 2.1
 : of the License, or (at your option) any later version.
 :
 : This library is distributed in the hope that it will be useful,
 : but WITHOUT ANY WARRANTY; without even the implied warranty of
 : MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 : GNU Lesser General Public License for more details.
 :
 : You should have received a copy of the GNU Lesser General Public License
 : along with this library; if not, write to the Free Software Foundation,
 : Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
 :)
xquery version "3.0";

import module "http://expath.org/ns/crypto";

let $private-key := util:binary-to-string(util:binary-doc(concat('xmldb:', resolve-uri('../resources/private-key.pem', concat(substring-after(system:get-module-load-path(), 'xmldb:'), '/')))))
let $expected-result :=
	<expected-result>l4MY6Yosjo7W60VJeXB/PQ==</expected-result>
let $actual-result :=
	<actual-result>
		{crypto:hmac("Short string for tests.", $private-key, "HMAC-MD5")}
	</actual-result>
let $condition := normalize-space($expected-result/text()) = normalize-space($actual-result/text())
	

return
	<result>
		{
		(
		if ($condition)
			then <result-token>passed</result-token>
			else <result-token>failed</result-token>
		, $actual-result
		)
		}
	</result>