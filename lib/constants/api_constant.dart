const protocol = "http";
// const domain = "192.168.1.46:3000";
const domain = "192.168.1.148:3000";
const wardrobeURLAPI = "$protocol://$domain/api/wardrobe";

Map<String, String> setHeaders() {
  return {
    'Content-Type':'application/json',
    'Accept':'application/json'
  };
}