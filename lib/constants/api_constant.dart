const protocol = "http";
// const domain = "192.168.1.41:3000";
const domain = "10.4.248.213:3000";
const wardrobeURLAPI = "$protocol://$domain/api/wardrobe";
const outfitURLAPI = "$protocol://$domain/api/outfit";
const componentURLAPI = "$protocol://$domain/api/component";
const postURLAPI = "$protocol://$domain/api/post";

Map<String, String> setHeaders() {
  return {
    'Content-Type':'application/json',
    'Accept':'application/json'
  };
}