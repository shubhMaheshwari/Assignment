// MDP to solve the grid problem using value iteration
#include<bits/stdc++.h>
using namespace std;

#define N 100

int n,m,end_state,wall;
float reward[N][N];
int end_state_x[N],end_state_y[N];
int wall_x[N],wall_y[N];
int start_x,start_y;
float step_reward;

float p_right = 0.8,p_wrong=0.1;
float team_val = 25.0;
float dicount_factor = 0.99;
float tolerance = 0.01;

// Utility 
float uti[N][N];

// Transaction table => no need for transition table we already know the mapping 
// With 0.8 p take the best action else with 0.2 take the wrong action

bool check_possible(int i,int j){
	// Check if inside the boundary
	if(i<0||j<0||i>=n||j>=n){
		return false;
	}

	// Check if its a wall
	for(int w=0;w<wall;w++)
		if(wall_x[w]==i&&wall_y[w]==j){
			return false;
		}

	return true;

}




float max_next_state(int i,int j)
{
	float max_val = -100.0,val;	
	if(check_possible(i+1,j)){
		if(j==0)
			// printf("%f\n", uti[i][j-1]);
		
		val = 0.8*uti[i+1][j];
		
		if(check_possible(i,j-1))
			val+= 0.1*uti[i][j-1];
			
		else
			val+= 0.1*uti[i][j];

		if(check_possible(i,j+1))
			val+=0.1*uti[i][j+1];
		else
			val+=0.1*uti[i][j];

		val += step_reward;		

		max_val = max(max_val,val);
	}

	if(check_possible(i,j+1)){


		val = 0.8*uti[i][j+1];
		
		if(check_possible(i+1,j))
			val+= 0.1*uti[i+1][j];
			
		else
			val+= 0.1*uti[i][j];

		if(check_possible(i-1,j))
			val+=0.1*uti[i-1][j];
		else
			val+=0.1*uti[i][j];

		val += step_reward;

		max_val = max(max_val,val);
	}

	if(check_possible(i-1,j)){

		val = 0.8*uti[i-1][j];
		
		if(check_possible(i,j+1))
			val+= 0.1*uti[i][j+1];
			
		else
			val+= 0.1*uti[i][j];

		if(check_possible(i,j-1))
			val+=0.1*uti[i][j-1];
		else
			val+=0.1*uti[i][j];

		val += step_reward;		

		max_val = max(max_val,val);
	}

	if(check_possible(i,j-1)){

		val = 0.8*uti[i][j-1];
		
		if(check_possible(i+1,j))
			val+= 0.1*uti[i+1][j];
			
		else
			val+= 0.1*uti[i][j];

		if(check_possible(i-1,j))
			val+=0.1*uti[i-1][j];
		else
			val+=0.1*uti[i][j];

		val += step_reward;

		max_val = max(max_val,val);
	}

	// printf("max_val:%f\n",max_val);

	// Pass the pass utility - step cost 
	return max_val;
}


int main()
{
	// Get reward for each state
	scanf("%d %d",&n,&m);
	for (int i = 0; i < n; ++i)
		for (int j = 0; j < m; ++j)
			scanf("%f",&reward[i][j]);

	// Get the walls and end state
	scanf("%d %d",&end_state,&wall);

	for (int i = 0; i < end_state; ++i){
		scanf("%d %d",&end_state_x[i],&end_state_y[i]);
		uti[end_state_x[i]][end_state_y[i]] = reward[end_state_x[i]][end_state_y[i]];	
	}

	for (int i = 0; i < wall; ++i)
		scanf("%d %d",&wall_x[i],&wall_y[i]);	


	// Get the start state
	scanf("%d %d",&start_x,&start_y);

	// Get the step cost
	scanf("%f",&step_reward);


	// How each iteration should work(Decision rule) 
	// assuming infinite horizon(policy converges) 
	// hence decision rule does not change with time(each epoch)

	// Bellman update
	// d = delta value
	float d=1,updated_val;
	for(int epoch=0;d > tolerance*(1-dicount_factor)/dicount_factor;epoch++)
	{
		// Error in this section 
		d = -100;
		// Update each grid value
		for (int i = 0; i < n; ++i)
			for (int j = 0; j < m; ++j){

			// If its a wall or end_state do const_val = true
			bool const_val=false;	

			// check for wall or end state
			for (int  e= 0; e < end_state;e++)
				if(end_state_x[e]==i&&end_state_y[e]==j)
				{
					// printf("end_state:%d %d\n",i,j );
					const_val=true;
					break;
				}

			if(const_val)
				continue;

			// Check if wall
			for (int  w= 0; w < wall;w++)
				if(wall_x[w]==i&&wall_y[w]==j)
					{
						// printf("wall:%d %d\n",i,j );
						const_val=true;
						break;
					}

			if(const_val)
				continue;

			float nst = max_next_state(i,j);
			updated_val = reward[i][j] + dicount_factor*nst;
			// printf("Updating:%d %d %f %f %f\n",i,j,reward[i][j],dicount_factor*nst,updated_val);

			d  = max(d,fabs(updated_val - uti[i][j]));
			
			uti[i][j] = updated_val;



		}
		printf("Epoch:%d Error:%f\n",epoch,d);


	}

	for (int i = 0; i < n; ++i){
		for (int j = 0; j < m; ++j)
			printf("%.3f ",uti[i][j] );
		printf("\n");
	}


	return 0;
}