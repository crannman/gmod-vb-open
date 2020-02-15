VehTable = {
  ["sl65amg"] = {
    Model = "models/tdmcars/sl65amg.mdl",
    Script = "scripts/vehicles/sl65amg.txt",
    Name = "Mercedes Benz SL65 AMG",
    Price = 220000,
    LicensePos = Vector(0, -100, 36),
    TrunkPos = Vector(0, -87, 37),
    TrunkLimit = 4,
    DefaultBodyGroups = "00000",
    Bodygroups = {
      Bumperf = {
        Id = 3,
        -- Numeric indices, values are for translation...
        -- Bodygroup := [X][X][X][SubModelsIndex][X][X]
        Submodels = {
          [0] = {
            Text = "Aucun pare-choc avant",
            Price = 0
          },
          [1] = {
            Text = "Pare-choc GT",
            Price = 930
          }
        }
      },
      Wing = {
        Id = 4,
        Submodels = {
          [0] = {
            Text = "Aucun spoiler",
            Price = 0
          },
          [1] = {
            Text = "Spoiler GT",
            Price = 560
          }
        }
      }
    }
  },
  ["mas_ghibli"] = {
    Model = "models/tdmcars/mas_ghibli.mdl",
    Script = "scripts/vehicles/mas_ghibli.txt",
    Name = "Maserati Ghibli S",
    Price = 250000,
    LicensePos = Vector(0, -120, 43),
    TrunkPos = Vector(0, -105, 50),
    TrunkLimit = 4,
    DefaultBodyGroups = "00000000",
    Bodygroups = {
      Bumperf = {
        Id = 5,
        Submodels = {
          [0] = {
            Text = "bumperfa",
            Price = 0
          },
          [1] = {
            Text = "bumperfg",
            Price = 0
          }
        }
      },
      Wing = {
        Id = 6,
        Submodels = {
          [0] = {
            Text = "winga",
            Price = 0
          },
          [1] = {
            Text = "wingb",
            Price = 0
          }
        }
      }
    }
  },
  ["c12"] = {
    Model = "models/tdmcars/zondac12.mdl",
    Script = "scripts/vehicles/c12.txt",
    Name = "Pagani Zonda C12",
    Price = 1000000,
    LicensePos = Vector(0, -103, 25),
    TrunkPos = Vector(0, -90, 35),
    TrunkLimit = 2,
    DefaultBodyGroups = "0000000",
    Bodygroups = {
      Bumperf = {
        Id = 4,
        Submodels = {
          [0] = {
            Text = "Aucun",
            Price = 0
          },
          [1] = {
            Text = "bumperf",
            Price = 0
          }
        }
      },
      Bumperr = {
        Id = 5,
        Submodels = {
          [0] = {
            Text = "bumperra",
            Price = 0
          },
          [1] = {
            Text = "bumpera",
            Price = 0
          }
        }
      },
      Wing = {
        Id = 6,
        Submodels = {
          [0] = {
            Text = "winga",
            Price = 0
          },
          [1] = {
            Text = "wingb",
            Price = 0
          }
        }
      }
    }
  },
  ["skyline_r34"] = {
    Model = "models/tdmcars/skyline_r34.mdl",
    Script = "scripts/vehicles/skyline_r34.txt",
    Name = "Nissan Skyline R34",
    Price = 100000,
    LicensePos = Vector(0, -109, 27),
    TrunkPos = Vector(-1, -94, 41),
    TrunkLimit = 4,
    DefaultBodyGroups = "000000000",
    Bodygroups = {
      Bumperr = {
        Id = 4,
        Submodels = {
          [0] = {
            Text = "bumperra",
            Price = 0
          },
          [1] = {
            Text = "bumperrb",
            Price = 0
          },
          [2] = {
            Text = "bumperrc",
            Price = 0
          }, 
          [3] = {
            Text = "bumperrd",
            Price = 0
          },
          [4] = {
            Text = "bumperre",
            Price = 0
          },
          [5] = {
            Text = "bumperrg",
            Price = 0
          },
          [6] = {
            Text = "bumperrf",
            Price = 0
          }      
        }
      },
      Bumperf = {
        Id = 3,
        Submodels = {
          [0] = {
            Text = "bumperfb",
            Price = 0
          },
          [1] = {
            Text = "bumperfa",
            Price = 0
          },
          [2] = {
            Text = "bumperfc",
            Price = 0
          }, 
          [3] = {
            Text = "bumperfd",
            Price = 0
          },
          [4] = {
            Text = "bumperfe",
            Price = 0
          },
          [5] = {
            Text = "bumperfg",
            Price = 0
          },
          [6] = {
            Text = "bumperff",
            Price = 0
          }
        }
      },
      Skirt = {
        Id = 5,
        Submodels = {
          [0] = {
            Text = "skirta",
            Price = 0
          },
          [1] = {
            Text = "skirtb",
            Price = 0
          },
          [2] = {
            Text = "skirtc",
            Price = 0
          }, 
          [3] = {
            Text = "skirtd",
            Price = 0
          },
          [4] = {
            Text = "skirte",
            Price = 0
          },
          [5] = {
            Text = "skirtf",
            Price = 0
          },
        }
      },
      Wing = {
        Id = 7,
        Submodels = {
          [0] = {
            Text = "winga",
            Price = 0
          },
          [1] = {
            Text = "wingb",
            Price = 0
          },
          [2] = {
            Text = "wingc",
            Price = 0
          }, 
          [3] = {
            Text = "wingd",
            Price = 0
          },
          [4] = {
            Text = "winge",
            Price = 0
          }
        }
      },
      Hood = {
        Id = 6,
        Submodels = {
          [0] = {
            Text = "hooda",
            Price = 0
          },
          [1] = {
            Text = "hoodb",
            Price = 0
          },
          [2] = {
            Text = "hoodc",
            Price = 0
          }, 
          [3] = {
            Text = "hoodd",
            Price = 0
          }
        }
      },
      Wheel = {
        Id = 8,
        Submodels = {
          [0] = {
            Text = "wheela",
            Price = 0
          },
          [1] = {
            Text = "wheelb",
            Price = 0
          },
          [2] = {
            Text = "wheelc",
            Price = 0
          }, 
        }
      }
    }
  },
}