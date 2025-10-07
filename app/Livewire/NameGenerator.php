<?php

namespace App\Livewire;

use App\Models\Name;
use Livewire\Component;

class NameGenerator extends Component
{

    public $name = "----------";

    public function generate()
    {
        // Fetch 2 random names
        $randomNames = Name::inRandomOrder()->limit(2)->pluck('name');

        // Combine them into a single string with a space in between
        $this->name = $randomNames->implode(' ');

        // You can return it, store it in a property, or do something else
        // return $combinedName;
    }

    public function render()
    {
        return view('livewire.name-generator');
    }
}
