var a = {x: 3, y: 4, greeting: "Hi"};
var b = {}; // empty object
console.assert(a.x === 3);
a.x = 7;
console.assert(a.x === 7);
a['x'] = 10;
var f = function (x, y) {
	return x+y;
};
f.xyz = 10;
var dist = function () {
	return this.x + this.y;
}
a.dist= dist;
a.anyname = dist;
console.assert(a.dist() === 14);
console.assert(dist.apply(a), 14);
console.assert(a.dist() === a.dist.apply(a));
var Point = function (x,y) {
    this.x = x;
	this.y = y;
};
var pt = new Point(2,3);
console.assert(pt.constructor === Point);
a = {x: 2, y: 3};
b = {x: 1, y: 6};
a.dist = dist;
console.assert(a.dist() === 5);
console.assert(a.dist.bind(b)() === 7);
console.assert(a.dist.apply(b) === 7);
// pt was earlier declared as 
// pt = new Point(2,3)

console.assert(pt.constructor === Point);

// add field z to Point's prototype object
Point.prototype.z = 10;

// pt inherits the field z
console.assert(pt.z === 10);

// pt doesn't own z; it inherits it
console.assert(pt.hasOwnProperty('z') === false);
console.assert(Point.prototype.hasOwnProperty('z') === true);
exports.Point = Point;
exports.dist = dist;
