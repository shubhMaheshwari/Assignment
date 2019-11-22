       // This solution is invalid now as questions changed.
       var data = {"Harshit": [10,20,30,40,50]};

       /* Part 1: Student with highest marks */
       function add(a, b) { return a + b; }

       var maxMarks = 0, studentWithMaxMarks;

       for(var name in data) {
           var sum = data[name].reduce(add);
           if (sum > maxMarks) {
               maxMarks = sum;
               studentWithMaxMarks = name;
           }   
       }
       console.log(studentWithMaxMarks, '\n');

       /* Part 2: Student(s) with max marks in 2nd subject */
       var students = [], max = 0;

       for(var name in data) {
           var marks = data[name][1];
           if (marks > max) {
               students = [];
               students.push(name);
               max = marks;
           } else if (marks == max) {
               students.push(name);
           }
       }

       console.log(students.join('\n'), '\n');

       /* Part 3: Average per subject */
       var avg = [0, 0, 0, 0, 0], numOfStudents = 0;

       for(var name in data) {
           for(var i = 0; i < 5; i++) {
               avg[i] += data[name][i];
           }
           numOfStudents++;
       }

       for(var i = 0; i < 5; i++) {
           avg[i] = avg[i] / numOfStudents;
       }

       console.log(avg.join('\n'), '\n');

       /* Part 4: Names of students with percent > 85 */
       function add(a, b) { return a + b; }

       var students = [];

       for(var name in data) {
           var sum = data[name].reduce(add);
           if (sum > 425) {
               students.push(name);
           }
       }
       students.sort();
       console.log(students.join('\n'), '\n');
