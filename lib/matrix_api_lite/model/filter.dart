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

enum EventFormat { client, federation }

class Filter {
  RoomFilter room;
  EventFilter presence;
  EventFilter accountData;
  EventFormat eventFormat;
  List<String> eventFields;

  Filter({
    this.room,
    this.presence,
    this.accountData,
    this.eventFormat,
    this.eventFields,
  });

  Filter.fromJson(Map<String, dynamic> json) {
    room = json['room'] != null ? RoomFilter.fromJson(json['room']) : null;
    presence = json['presence'] != null
        ? EventFilter.fromJson(json['presence'])
        : null;
    accountData = json['account_data'] != null
        ? EventFilter.fromJson(json['account_data'])
        : null;
    eventFormat = json['event_format'] != null
        ? EventFormat.values.firstWhere(
            (e) => e.toString().split('.').last == json['event_format'])
        : null;
    eventFields = json['event_fields'] != null
        ? json['event_fields'].cast<String>()
        : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (room != null) {
      data['room'] = room.toJson();
    }
    if (presence != null) {
      data['presence'] = presence.toJson();
    }
    if (eventFormat != null) {
      data['event_format'] = eventFormat.toString().split('.').last;
    }
    if (eventFields != null) {
      data['event_fields'] = eventFields;
    }
    if (accountData != null) {
      data['account_data'] = accountData.toJson();
    }
    return data;
  }
}

class RoomFilter {
  List<String> notRooms;
  List<String> rooms;
  StateFilter ephemeral;
  bool includeLeave;
  StateFilter state;
  StateFilter timeline;
  StateFilter accountData;

  RoomFilter({
    this.notRooms,
    this.rooms,
    this.ephemeral,
    this.includeLeave,
    this.state,
    this.timeline,
    this.accountData,
  });

  RoomFilter.fromJson(Map<String, dynamic> json) {
    notRooms = json['not_rooms']?.cast<String>();
    rooms = json['rooms']?.cast<String>();
    state = json['state'] != null ? StateFilter.fromJson(json['state']) : null;
    includeLeave = json['include_leave'];
    timeline = json['timeline'] != null
        ? StateFilter.fromJson(json['timeline'])
        : null;
    ephemeral = json['ephemeral'] != null
        ? StateFilter.fromJson(json['ephemeral'])
        : null;
    accountData = json['account_data'] != null
        ? StateFilter.fromJson(json['account_data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (notRooms != null) {
      data['not_rooms'] = notRooms;
    }
    if (rooms != null) {
      data['rooms'] = rooms;
    }
    if (ephemeral != null) {
      data['ephemeral'] = ephemeral.toJson();
    }
    if (includeLeave != null) {
      data['include_leave'] = includeLeave;
    }
    if (state != null) {
      data['state'] = state.toJson();
    }
    if (timeline != null) {
      data['timeline'] = timeline.toJson();
    }
    if (accountData != null) {
      data['account_data'] = accountData.toJson();
    }
    return data;
  }
}

class EventFilter {
  int limit;
  List<String> senders;
  List<String> types;
  List<String> notRooms;
  List<String> notSenders;

  EventFilter(
      {this.limit, this.senders, this.types, this.notRooms, this.notSenders});

  EventFilter.fromJson(Map<String, dynamic> json) {
    limit = json['limit'];
    types = json['senders']?.cast<String>();
    types = json['types']?.cast<String>();
    notRooms = json['not_rooms']?.cast<String>();
    notSenders = json['not_senders']?.cast<String>();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (limit != null) data['limit'] = limit;
    if (types != null) data['types'] = types;
    if (notRooms != null) data['not_rooms'] = notRooms;
    if (notSenders != null) data['not_senders'] = notSenders;
    return data;
  }
}

class StateFilter extends EventFilter {
  List<String> notTypes;
  bool lazyLoadMembers;
  bool includeRedundantMembers;
  bool containsUrl;

  StateFilter({
    this.notTypes,
    this.lazyLoadMembers,
    this.includeRedundantMembers,
    this.containsUrl,
    int limit,
    List<String> senders,
    List<String> types,
    List<String> notRooms,
    List<String> notSenders,
  }) : super(
          limit: limit,
          senders: senders,
          types: types,
          notRooms: notRooms,
          notSenders: notSenders,
        );

  StateFilter.fromJson(Map<String, dynamic> json) {
    final eventFilter = EventFilter.fromJson(json);
    limit = eventFilter.limit;
    senders = eventFilter.senders;
    types = eventFilter.types;
    notRooms = eventFilter.notRooms;
    notSenders = eventFilter.notSenders;

    notTypes = json['not_types']?.cast<String>();
    lazyLoadMembers = json['lazy_load_members'];
    includeRedundantMembers = json['include_redundant_members'];
    containsUrl = json['contains_url'];
  }

  @override
  Map<String, dynamic> toJson() {
    final data = super.toJson();
    if (limit != null) {
      data['limit'] = limit;
    }
    if (notTypes != null) {
      data['not_types'] = notTypes;
    }
    if (lazyLoadMembers != null) {
      data['lazy_load_members'] = notTypes;
    }
    if (includeRedundantMembers != null) {
      data['include_redundant_members'] = notTypes;
    }
    if (containsUrl != null) {
      data['contains_url'] = notTypes;
    }
    return data;
  }
}
