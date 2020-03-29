# TimeTravel

## TODO 
- add your google api key in the Utils.swift file

# TimeTravel with callbacks

## Protocols

### Location

Methods:

| visibility | name | args | return | descr |
| ---------- | ---- | ---- | ------ | ----- |
| public | lat  | none | float  | return the latitude |
| public | long | none | float  | return the longitude |
| public | addr | none | string | return the address |
| public | isDefined | none | bool | return whether or not the location is "the empty location" |

### User

Methods:

| visibility | name | args | return | descr |
| ---------- | ---- | ---- | ------ | ----- |
| public | position    | completion `(loc: Location) -> void` | void       | call completion when location of user is retreived. |
| public | destination | none                                 | `Location` | return the destination of the user. |
| public | changeDest  | location as a `Location`             | `User`     | return a new user with a the new destination |
| public | changeDest  | place as a `string`                  | `User`     | return a new user with a the new destination |
| public | travelTime  | completion `(time: int) -> void`     | void       | call completion when the computation of time (in second) needed by user to go to his destination is completed |

### Map

Methods:

| visibility | name | args | return | descr |
| ---------- | ---- | ---- | ------ | ----- |
| public | findPlace | place as `string` (the name of the place), completion `(loc: Location) -> void` | void | give the location of a place |
| public | timeA2B   | location A and B as `Location`, completion `(time: int) -> void`                | void | give the fastest time needed by user to go from A to B (in seconds) |

### RestFulGetAPI

Methods:

| visibility | name | args | return | descr |
| ---------- | ---- | ---- | ------ | ----- |
| public | call | function as `string` (the end of the url), params (`Dictionary<string,string>`), completion `(resp: JSON) -> void` | void | call a get function on an API and return the results |


## Implementations

### SimpleLocation

Should implements  `Location`.

Methods:

| visibility | name | args | return | descr |
| ---------- | ---- | ---- | ------ | ----- |
| public | _constructor_ | lat as float, long as float, address as string | _N/A_ | constructor, only do association |
| public | _constructor_ | none | _N/A_ | constructor, create an object "empty location" |
| public | lat | none | float | return the latitude |
| public | long | none | float | return the longitude |
| public | addr | none | string | return the address |
| public | isDefined | none | bool | return whether or not the location is the "empty location" |

### IphoneUser

Should implements  `User`.

Methods:

| visibility | name | args | return | descr |
| ---------- | ---- | ---- | ------ | ----- |
| public | _constructor_ | map as `Map`, destination as `Location` (default: the "empty location") | _N/A_ | constructor, only do association |
| public | position    | completion `(loc: Location) -> void` | void       | call completion when location of user is retreived. |
| public | destination | none                                 | `Location` | return the destination of the user. |
| public | changeDest  | location as a `Location`             | `User`     | return a new user with the new destination |
| public | changeDest  | place as a `string`                  | `User`     | return a new user with a the new destination |
| public | travelTime  | completion `(time: int) -> void`     | void       | call completion when the computation of time (in second) needed by user to go to his destination is completed |

### GoogleMapAPI

Should implements `RestFulGetAPI`.

Methods:

Methods:

| visibility | name | args | return | descr |
| ---------- | ---- | ---- | ------ | ----- |
| public | _constructor_ | none | _N/A_ | constructor |
| public | call | function as `string` (the end of the url), params (`Dictionary<string,string>`), completion `(resp: JSON) -> void` | void | call a get function on an API and return the results |

### MapGoogle

Should implements  `Map`.

Methods:

| visibility | name | args | return | descr |
| ---------- | ---- | ---- | ------ | ----- |
| public | _constructor_ | api as `GoogleMapAPI` | _N/A_ | constructor |
| public | findPlace | place as `string` (the name of the place), completion `(loc: Location) -> void` | void | give the location of a place |
| public | timeA2B   | location A and B as `Location`, completion `(time: int) -> void`                | void | give the fastest time needed by user to go from A to B (in seconds) |


## Program

### pseudo-code of main program

```
let api = GoogleMapAPI();
let map = MapAPI(api);

let user = IphoneUser(map);

// when user has selected location
user = user.changeDestination(newDestination);
user.travelTime(
    (int time) -> void {
        print(time)
    }
)
```
