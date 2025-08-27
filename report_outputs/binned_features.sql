(CASE 
  WHEN (`a`.`integer_all_high` IS NULL 
  OR `a`.`integer_all_high` IN ('na', 'NA', 'null', 'NULL', 'none', 'NONE', 'n/a', 'N/A', 'nan', 'NaN', '', ' ')) THEN 'NA' 
  WHEN ((1.0 * IFNULL(`a`.`integer_all_high`, 'NA')) < (810.5)) THEN 1 
  ELSE 2
END) AS `binned_integer_all_high`,
(CASE 
  WHEN (`a`.`integer_dominant` IS NULL 
  OR `a`.`integer_dominant` IN ('na', 'NA', 'null', 'NULL', 'none', 'NONE', 'n/a', 'N/A', 'nan', 'NaN', '', ' ')) THEN 'NA' 
  WHEN ((1.0 * IFNULL(`a`.`integer_dominant`, 'NA')) < (947)) THEN 1 
  ELSE 2
END) AS `binned_integer_dominant`,
(CASE 
  WHEN (`a`.`integer_random` IS NULL 
  OR `a`.`integer_random` IN ('na', 'NA', 'null', 'NULL', 'none', 'NONE', 'n/a', 'N/A', 'nan', 'NaN', '', ' ')) THEN 'NA' 
  WHEN ((1.0 * IFNULL(`a`.`integer_random`, 'NA')) < (126)) THEN 1 
  WHEN ((1.0 * IFNULL(`a`.`integer_random`, 'NA')) < (132)) THEN 2 
  WHEN ((1.0 * IFNULL(`a`.`integer_random`, 'NA')) < (423.5)) THEN 3 
  WHEN ((1.0 * IFNULL(`a`.`integer_random`, 'NA')) < (433)) THEN 4 
  WHEN ((1.0 * IFNULL(`a`.`integer_random`, 'NA')) < (566.5)) THEN 5 
  ELSE 6
END) AS `binned_integer_random`,
(CASE 
  WHEN (`a`.`integer_some_low` IS NULL 
  OR `a`.`integer_some_low` IN ('na', 'NA', 'null', 'NULL', 'none', 'NONE', 'n/a', 'N/A', 'nan', 'NaN', '', ' ')) THEN 'NA' 
  WHEN ((1.0 * IFNULL(`a`.`integer_some_low`, 'NA')) < (154.5)) THEN 1 
  WHEN ((1.0 * IFNULL(`a`.`integer_some_low`, 'NA')) < (280)) THEN 2 
  WHEN ((1.0 * IFNULL(`a`.`integer_some_low`, 'NA')) < (444.5)) THEN 3 
  WHEN ((1.0 * IFNULL(`a`.`integer_some_low`, 'NA')) < (562.5)) THEN 4 
  WHEN ((1.0 * IFNULL(`a`.`integer_some_low`, 'NA')) < (811)) THEN 5 
  WHEN ((1.0 * IFNULL(`a`.`integer_some_low`, 'NA')) < (856)) THEN 6 
  WHEN ((1.0 * IFNULL(`a`.`integer_some_low`, 'NA')) < (979)) THEN 7 
  ELSE 8
END) AS `binned_integer_some_low`,
(CASE 
  WHEN (`a`.`numeric_all_high` IS NULL 
  OR `a`.`numeric_all_high` IN ('na', 'NA', 'null', 'NULL', 'none', 'NONE', 'n/a', 'N/A', 'nan', 'NaN', '', ' ')) THEN 'NA' 
  WHEN ((1.0 * IFNULL(`a`.`numeric_all_high`, 'NA')) < (561.4)) THEN 1 
  WHEN ((1.0 * IFNULL(`a`.`numeric_all_high`, 'NA')) < (641.69)) THEN 2 
  ELSE 3
END) AS `binned_numeric_all_high`,
(CASE 
  WHEN (`a`.`numeric_dominant` IS NULL 
  OR `a`.`numeric_dominant` IN ('na', 'NA', 'null', 'NULL', 'none', 'NONE', 'n/a', 'N/A', 'nan', 'NaN', '', ' ')) THEN 'NA' 
  WHEN ((1.0 * IFNULL(`a`.`numeric_dominant`, 'NA')) < (487.55)) THEN 1 
  WHEN ((1.0 * IFNULL(`a`.`numeric_dominant`, 'NA')) < (490.94)) THEN 2 
  WHEN ((1.0 * IFNULL(`a`.`numeric_dominant`, 'NA')) < (978.45)) THEN 3 
  ELSE 4
END) AS `binned_numeric_dominant`,
(CASE 
  WHEN (`a`.`numeric_random` IS NULL 
  OR `a`.`numeric_random` IN ('na', 'NA', 'null', 'NULL', 'none', 'NONE', 'n/a', 'N/A', 'nan', 'NaN', '', ' ')) THEN 'NA' 
  WHEN ((1.0 * IFNULL(`a`.`numeric_random`, 'NA')) < (102.8)) THEN 1 
  WHEN ((1.0 * IFNULL(`a`.`numeric_random`, 'NA')) < (208.82)) THEN 2 
  WHEN ((1.0 * IFNULL(`a`.`numeric_random`, 'NA')) < (389)) THEN 3 
  WHEN ((1.0 * IFNULL(`a`.`numeric_random`, 'NA')) < (445.36)) THEN 4 
  WHEN ((1.0 * IFNULL(`a`.`numeric_random`, 'NA')) < (525.58)) THEN 5 
  WHEN ((1.0 * IFNULL(`a`.`numeric_random`, 'NA')) < (612.76)) THEN 6 
  WHEN ((1.0 * IFNULL(`a`.`numeric_random`, 'NA')) < (737.27)) THEN 7 
  WHEN ((1.0 * IFNULL(`a`.`numeric_random`, 'NA')) < (834.99)) THEN 8 
  WHEN ((1.0 * IFNULL(`a`.`numeric_random`, 'NA')) < (909.19)) THEN 9 
  ELSE 10
END) AS `binned_numeric_random`,
(CASE 
  WHEN (`a`.`numeric_some_low` IS NULL 
  OR `a`.`numeric_some_low` IN ('na', 'NA', 'null', 'NULL', 'none', 'NONE', 'n/a', 'N/A', 'nan', 'NaN', '', ' ')) THEN 'NA' 
  WHEN ((1.0 * IFNULL(`a`.`numeric_some_low`, 'NA')) < (735.57)) THEN 1 
  WHEN ((1.0 * IFNULL(`a`.`numeric_some_low`, 'NA')) < (809.52)) THEN 2 
  ELSE 3
END) AS `binned_numeric_some_low`,
(CASE 
  WHEN (`a`.`registration_date` IS NULL 
  OR `a`.`registration_date` IN ('na', 'NA', 'null', 'NULL', 'none', 'NONE', 'n/a', 'N/A', 'nan', 'NaN', '', ' ')) THEN 'NA' 
  WHEN (1.0 * TIMESTAMPDIFF(WEEK, IFNULL(`a`.`registration_date`, 'NA'), `a`.`order_date`) < (15.79)) THEN 1 
  WHEN (1.0 * TIMESTAMPDIFF(WEEK, IFNULL(`a`.`registration_date`, 'NA'), `a`.`order_date`) < (40.07)) THEN 2 
  WHEN (1.0 * TIMESTAMPDIFF(WEEK, IFNULL(`a`.`registration_date`, 'NA'), `a`.`order_date`) < (52.64)) THEN 3 
  WHEN (1.0 * TIMESTAMPDIFF(WEEK, IFNULL(`a`.`registration_date`, 'NA'), `a`.`order_date`) < (53.21)) THEN 4 
  ELSE 5
END) AS `binned_weeks_since_registration_date`,
(CASE 
  WHEN (`a`.`character_all_high` IS NULL OR `a`.`character_all_high` IN ('na', 'NA', 'null', 'NULL', 'none', 'NONE', 'n/a', 'N/A', 'nan', 'NaN', '', ' ')) THEN 'NA' 
  WHEN `a`.`character_all_high` IN ('0mdBgj0O', 'IZnohLq8', 'QGsM0Jyk', 'EeosNazm', 'gA5evBMZ', 'mXNv5k38', 'sX2BaueM', 'o9xL28OQ', 'ucjY4X3b', '7NmlPfAt', 'rmYt8pyq', 'y0WBDPxr', 'CSNYqIzj', 'h313b6ur', 'zUhTKiVi', 'kHCr6efV', 'TL3bHz7H', 'Ai4uHDz3', 'yvn6cHu8', '2mbMAGSO', 'gn8Pgkn2', 'Gu1MuHgS', 'tC1gyeMG', 'Vv1i5p8H', 'Nqgo7BfT', 'M7LUberl', 'gTAILETe', 'Eu6dhoDA', 'JILPXk7R', '0pXTZOpB') THEN 1 
  ELSE 1 
END) AS `binned_character_all_high`,
(CASE 
  WHEN (`a`.`character_dominant` IS NULL OR `a`.`character_dominant` IN ('na', 'NA', 'null', 'NULL', 'none', 'NONE', 'n/a', 'N/A', 'nan', 'NaN', '', ' ')) THEN 'NA' 
  WHEN `a`.`character_dominant` IN ('Qt0UPHXb', 'Ab0mY4nE', 'S3nihhE1', 'eNX1wfOY', '7wbQDsER', 'xWMrj7Dr', 'WK79oKvL', 'mfbvYfuk', 'OCImDJyf', 'DNjUQJxq', 'B5IYlg0M', 'Us6saYHa', 'xQCkWJxb', 'gQy9GQsf', 'tU1Rt38m', 'SI61ABcF', 'QdK2Ic54', 'pacJxi0f', '0KSEA9pn', '5AIiJaB0', 'bYt3nn6X', 'RCpwyOqK', 'i0Rfjoa6', 'tVUcH63b', 'pJsmKodH') THEN 1 
  WHEN `a`.`character_dominant` IN ('R8Qx2GZT', 's149GX1r', '0fJWovw3', 'SjEes73k', '2mb0Az22', 'QyhVv9KV', '445XKVxU', 'VHddZba4', 'p3jhxqsL', '0dZkjh2b', 'd9O26foE', 'C1h8xyHL', 'zRUj8Xc3', 'FDyAKhmI', 'LafICQVV', 'xvtNSNYp', '90nUX640', 'GOrslvuN', 'actibZkl', 'IrKDxHHI', 'EJrtemuk', '1EyCmwG7', 'f4HV7z0h', 'H1Bd5xco', 'NfUWXxPV', 'Gb1ofuh3', 'lS4pmj04', 'EnmLaOEm', 'n1XNt8bU', 'QnOxIaFy', 'GQ3Y0xr3', '1pkKnsYx', 'sozRg3St', 'GtzJ7dNv', '9khvpoME', 'R7eZC0vQ', 'AGwsUw2R') THEN 2 
  WHEN `a`.`character_dominant` IN ('TO0wnhBV', '66Ufm1QM', 'PSoZT8M4', 'A4eQWX9i', '9ROmGygf', 'V34cFT9B', 'hTQsm0bz', 'rPu6EGkr', 'XrHDeKwI', 'jZ2fnltN', 'jlXaDZ84', 'jMBcoLAn', 'A03t0cAG', 'glSNOBlC', '9v98DTdH', 'hAzdGDw2', 'Nvu9RZuE', 'gC7hcyxq', 'HiBkIfV0', 'vqqesyPJ', 'LDqODXNH', 'b3MdLJqQ', 'KqZlnzqy', '9MifYw95', 'TYY0h5C1', 'lQOa2JOM', 'TiLJkfet', 'RCB0iilh', '376rYNbh', 'AaXgsBZy', 'AYKkU0Yo', 'g4f8ZXIQ', 'Nx29oyFc', '1YIAgh8t', 'ms41HwMb') THEN 3 
  ELSE 4 
END) AS `binned_character_dominant`,
(CASE 
  WHEN (`a`.`character_random` IS NULL OR `a`.`character_random` IN ('na', 'NA', 'null', 'NULL', 'none', 'NONE', 'n/a', 'N/A', 'nan', 'NaN', '', ' ')) THEN 'NA' 
  WHEN `a`.`character_random` IN ('frtxkt7v', 'IccPT81G', '9i35JJE1', 'fezRe4zE', '7EZcQdk7', 'Nqpw7MSe', 'jKfzt1y1', 'X1RkqeiB', '4o61ERsj', 'YCF5GHw4', 'O0EpucHH', 'Y0HYb4cL', 'qYCkHuxg', 'XY6EVbb1', 'xQ6ByMww', 'z1o2upRI', 'ELIVBD6T', 'nMVZckSI', 'hZD4tdjO', 'YMLqSm7v', 'lh7FLGko', '9WUqjTs7', 'XKkZDg1d', 'JlCtUk4z', 'jf2R7lGC') THEN 1 
  WHEN `a`.`character_random` IN ('DQNQ4Qxy', 'Gp08iiPU', 'Fe3SqF15', 'fi1IoPuM', 'UBSX0sYg', 'XbnjnINT', 'rQMA17p8', 'soDgOvze', 'GX1w21Eh', 'DACPNqQL', 'JZVSDKEb', 'DDBbIgkT', 'kQqdaovB', 'FLNrStM4', 'wxeQlSYg', 'FpkIYVAm', 'p6zYrpzF', 'ezminZSn', 'JLdKvH89', 'em23eq5Q', 'JwbtUCUD', '2gbLdSfE', 'oainyIvV', '1VwfLfvA', 'SIXHheLC', 'dctu43oo', 'Y8hlYRrr', 'InPbCuCo', 'la4SogtA', 'tazwgpJP', '1zCB5Rgb', 'XOdf6W3Q', 'dJBQrdTO', 'bfrMo56m', 'co3QvOlB', 'coozZSGG', 'Cy3nx0Y6', '2fiHqMS8', 'dsSRxvhA', 'TXuILqL8', 'W8RcCEKN', 'bMVIaWsi', 'zAA1WIBI', 'tCcCGsPf', 'ZCsbMv61', 'V6UntRSv') THEN 2 
  WHEN `a`.`character_random` IN ('B559FIpP', 'GCcoIwVW', '7S2NEnvW', 'sxMVUKQ8', 'V9LA9SYw', '6naXwwSV', '35l6Q20X', 'aR69BTUD', 'XKQZOTWX', 'WO949b9y', 'JP4tkZYz', 'MfVWqYXn', 'VH8KflUk', 'Y49lihoU', 'FSYKdCDJ', 'ouvCyonu', 'qJVGovVy', 'Tzx9jR4g', 'WwooBFvk', 'kBJqWD82', 'Uq5Ucthx', 'MEgQI0pT', 'PGcy7ms5', 'U9osvusN', 'ZCb43oFV', '7Mi3bO1U', 'pQQ9Wcrq', 'oPtiRz7N', 'IZv0AjT8', 'CLqSGN3g', 'Z7ezXu2H', 'hz7FU8Xp', 'PGvxtYgo', '4ggZhUz4') THEN 3 
  WHEN `a`.`character_random` IN ('ZwY6BYYb', 'C7J3L6Wm', 'yMwlt3I7', 'GP5SRQWQ', 'fTr5ECyz', 'KpWtcY9i', '0WSbwoLQ', 'aDPg6oQ0', 'Qxw8oOWf', 'TpUDLzFG', 'U4YkMxKz', '8fncOdeX', 'XUst8f3q', 'WXsSOyvc', 'vjRjrmbs', 'xu7Iey3R', 'z5FYBmO5', 'Yd35fc6j', '4mZ1GBd1', 'oOaQ4sPR', 'byEriaxc', 'K5rALyqi', 'EgAFjqma', 'LHcGFr49', '2j5xOn7M') THEN 4 
  ELSE 5 
END) AS `binned_character_random`,
(CASE 
  WHEN (`a`.`character_some_low` IS NULL OR `a`.`character_some_low` IN ('na', 'NA', 'null', 'NULL', 'none', 'NONE', 'n/a', 'N/A', 'nan', 'NaN', '', ' ')) THEN 'NA' 
  WHEN `a`.`character_some_low` IN ('hxUJvDNu', 'JSgqNDHQ', 'wNNgk3tp', 'fVZmg025', '4fNrXPwp', 'o6n18thg', 'GXB49Syn', 'fbgjuVjk', 'bD8EyKM2', 'CXStnYBs', 'x0F8DjG4', 'Ve4c915p', 'DB1pryXj', 'ePIKrvA1', 'iQSGTJS5', 'Irvs0Z6B', 'OfWryt7D', '2FwyPX1Z', 'eA5xcI3X', 'tQwgyV06', '1kxOrDoe', 'LOHFPrAe', 'VWNCjIRn', 'WqswIlr1', 'QZU5NuQd', 'dPA8tbew', '2nomJ6NX', 'UKJhd60s', '3YsH8YGd', 'Pl0alM8m', '4w4C1cdu', 'QTiy8aPa', 'YczAVuDl', 'wmmQXgIX', 'hfyerj2P', 'bsbEtbVn', 'LnQlCkPM', 'GsdQg1UJ') THEN 1 
  WHEN `a`.`character_some_low` IN ('eH0jA0iY', 'onz23CmL', '3wTPwFsX', 'eBgjcPDS', '7BzcfEYN', 'K1NzkLDV', 'dOCp6DQH', 'iGnwEPq9', 'BGYJYWnB', 'LmP3US56', 'B0eiaHaU', 'RMswfLGh', 'IXe9hsMP', 'oUjokKpM', 'qhEMlRTg', 'Ka5AwKQX', '6HOZtYY3', 'ME1LkkOb', '7IutlfUp', 'ojGWgLhG', 'XEzpblVk', 'vftZoXhl', '1LmRjBdT', 'gjtorkTT', 'WAqTcER7', 'OMeihlGV', 'Rv5gE8zG', 'EHW3vxYo', 'cYjgdAzC', '9eurxGJe', 'kylOG6YH', '2hEO68jQ', 'DAytSPRZ', 'JPxan0aE', 'qH4JE9Il', 'YF1TiUTm', 'pBrBNdVx', 'a0zHKOxO', 'tpgPsRIw', 'EV2490ix', 'K7lRs4we', '8JfxGkhC', 'yaMgAk6Q', 'I9Ockicg', 'BIZ4N2o7', 'mn73i6qJ', 'Cpy14vaz', 'VAQUiq28') THEN 2 
  ELSE 3 
END) AS `binned_character_some_low`,

