import re

def get_flag(code):
    parts = code.split('-')
    country = parts[-1].upper()
    
    lang_to_country = {
        'OM': 'ET', 'AF': 'ZA', 'AK': 'GH', 'SQ': 'AL', 'AM': 'ET', 'AR': 'SA',
        'HY': 'AM', 'AS': 'IN', 'AST': 'ES', 'AY': 'BO', 'AWA': 'IN', 'AZ': 'AZ',
        'BM': 'ML', 'EU': 'ES', 'BE': 'BY', 'BN': 'BD', 'BHO': 'IN', 'BRX': 'IN',
        'BS': 'BA', 'BRH': 'PK', 'BR': 'FR', 'BG': 'BG', 'MY': 'MM', 'YUE': 'HK',
        'CA': 'ES', 'CEB': 'PH', 'SHU': 'TD', 'HNE': 'IN', 'NY': 'MW', 'CO': 'FR',
        'HR': 'HR', 'CS': 'CZ', 'DA': 'DK', 'DOI': 'IN', 'NL': 'NL', 'EO': 'UN',
        'ET': 'EE', 'EE': 'GH', 'FAN': 'GQ', 'FO': 'FO', 'FIL': 'PH', 'FI': 'FI',
        'FR': 'FR', 'FY': 'NL', 'FF': 'SN', 'GAN': 'CN', 'GL': 'ES', 'KA': 'GE',
        'DE': 'DE', 'EL': 'GR', 'GN': 'PY', 'GU': 'IN', 'HAK': 'CN', 'HT': 'HT',
        'BGC': 'IN', 'HA': 'NG', 'HE': 'IL', 'HI': 'IN', 'HIL': 'PH', 'HMN': 'CN',
        'HU': 'HU', 'IS': 'IS', 'IG': 'NG', 'ILO': 'PH', 'ID': 'ID', 'GA': 'IE',
        'XH': 'ZA', 'IT': 'IT', 'JA': 'JP', 'JV': 'ID', 'KAB': 'DZ', 'KN': 'IN',
        'KR': 'NG', 'KS': 'IN', 'KK': 'KZ', 'KM': 'KH', 'KHA': 'IN', 'KI': 'KE',
        'RW': 'RW', 'RN': 'BI', 'KG': 'CD', 'KOK': 'IN', 'KO': 'KR', 'KRI': 'SL',
        'KU': 'IQ', 'KMR': 'TR', 'KY': 'KG', 'LO': 'LA', 'LA': 'VA', 'LV': 'LV',
        'LN': 'CD', 'LT': 'LT', 'LU': 'CD', 'LG': 'UG', 'LB': 'LU', 'MK': 'MK',
        'MAG': 'IN', 'MG': 'MG', 'MAI': 'IN', 'MS': 'MY', 'ML': 'IN', 'MT': 'MT',
        'MNI': 'IN', 'MR': 'IN', 'MWR': 'IN', 'MI': 'NZ', 'NAN': 'TW', 'MN': 'MN',
        'LUS': 'IN', 'NE': 'NP', 'OC': 'FR', 'OR': 'IN', 'PS': 'AF', 'FA': 'IR',
        'PL': 'PL', 'PA': 'IN', 'QU': 'PE', 'RAJ': 'IN', 'RO': 'RO', 'RM': 'CH',
        'RU': 'RU', 'SM': 'WS', 'SA': 'IN', 'SAT': 'IN', 'SKR': 'PK', 'GD': 'GB',
        'SR': 'RS', 'ST': 'LS', 'TN': 'BW', 'SN': 'ZW', 'SCN': 'IT', 'SD': 'PK',
        'SI': 'LK', 'SK': 'SK', 'SL': 'SI', 'SO': 'SO', 'SU': 'ID', 'SW': 'TZ',
        'SV': 'SE', 'TG': 'TJ', 'ZGH': 'MA', 'TA': 'IN', 'TT': 'RU', 'TE': 'IN',
        'TH': 'TH', 'TI': 'ER', 'TPI': 'PG', 'TO': 'TO', 'TCY': 'IN', 'TR': 'TR',
        'UK': 'UA', 'UR': 'PK', 'UG': 'CN', 'UZ': 'UZ', 'VEC': 'IT', 'VI': 'VN',
        'WAR': 'PH', 'CY': 'GB', 'WO': 'SN', 'WUU': 'CN', 'HSN': 'CN', 'TS': 'ZA',
        'YI': 'IL', 'YO': 'NG', 'ZU': 'ZA'
    }
    
    if len(country) != 2:
        country = lang_to_country.get(country, 'UN')
        
    if country == 'UN' or len(country) != 2:
        return '🏳️'
        
    return chr(ord(country[0]) + 127397) + chr(ord(country[1]) + 127397)

with open('c:/foco/lib/core/languages.dart', 'r', encoding='utf-8') as f:
    text = f.read()

# Update AppLanguage class definition
text = text.replace(
    '  final String code;\n\n  const AppLanguage(this.name, this.code);',
    '  final String code;\n  final String flag;\n\n  const AppLanguage(this.name, this.code, this.flag);'
)

# Update list entries
def repl_match(m):
    name = m.group(1)
    code = m.group(2)
    flag = get_flag(code)
    return f"AppLanguage('{name}', '{code}', '{flag}')"

text = re.sub(r"AppLanguage\('(.*?)', '(.*?)'\)", repl_match, text)

with open('c:/foco/lib/core/languages.dart', 'w', encoding='utf-8') as f:
    f.write(text)

print("Flags added successfully.")
