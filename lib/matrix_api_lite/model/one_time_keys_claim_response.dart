/*
 *   Matrix API Lite
 *   Copyright (C) 2019, 2020, 2021 Famedly GmbH
 *
 *   This program is free software: you can redistribute it and/or modify
 *   it under the terms of the GNU Affero General Public License as
 *   published by the Free Software Foundation, either version 3 of the
 *   License, or (at your option) any later version.
 *
 *   This program is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 *   GNU Affero General Public License for more details.
 *
 *   You should have received a copy of the GNU Affero General Public License
 *   along with this program.  If not, see <https://www.gnu.org/licenses/>.
 */

import '../utils/map_copy_extension.dart';

class OneTimeKeysClaimResponse {
  Map<String, dynamic> failures;
  Map<String, Map<String, dynamic>> oneTimeKeys;

  OneTimeKeysClaimResponse.fromJson(Map<String, dynamic> json) {
    failures = (json['failures'] as Map<String, dynamic>)?.copy() ?? {};
    // We still need a Map<...>.from(...) to ensure all second-level entries are also maps
    oneTimeKeys = Map<String, Map<String, dynamic>>.from(
        (json['one_time_keys'] as Map<String, dynamic>).copy());
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (failures != null) {
      data['failures'] = failures;
    }
    if (oneTimeKeys != null) {
      data['one_time_keys'] = oneTimeKeys;
    }
    return data;
  }
}