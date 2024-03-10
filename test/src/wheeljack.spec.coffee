describe "Wheeljack", ->

  beforeEach ->
    @Wheeljack = require 'wheeljack'
    @object =
      foo: 1
      bar:
        baz:
          qux: 2
    @wheeljack = new @Wheeljack(@object)


  describe "#get", ->

    it "can get a value", ->
      expect(@wheeljack.get('foo')).         toBe 1
      expect(@wheeljack.get('bar.baz.qux')). toBe 2


  describe "#getOr", ->

    it "can get a value, or an alternat", ->
      or99 = @wheeljack.getOr(99)
      expect(or99('foo')).         toBe  1, "Found top"
      expect(or99('bar.baz.qux')). toBe  2, "Found nested"
      expect(or99('boo')).         toBe 99, "Alternate value"


  describe "#set", ->

    it "can set a value", ->
      @wheeljack.set('foo', 2)
      expect(@object.foo).toBe 2,              "Single level"

      @wheeljack.set('bar.baz.qux', 99)
      expect(@object.bar.baz.qux).toBe 99,     "Nested exists"

      @wheeljack.set('does.not.exist', 99)
      expect(@object.does.not.exist).toBe 99,  "Nested, does not exist"


  describe "#swap", ->

    it "can swap out the data object", ->
      @wheeljack.swap(a: 1)
      expect(@wheeljack.object).toEqual a: 1
